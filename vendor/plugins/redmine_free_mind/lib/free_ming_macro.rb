# Free Mind plugin for Redmine
# Copyright (C) 2011  Haruyuki Iida & Takashi Takebayashi
#
# This program is free software; you can redistribute it and/or
# modify it under the terms of the GNU General Public License
# as published by the Free Software Foundation; either version 2
# of the License, or (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program; if not, write to the Free Software
# Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.
require 'redmine'

module FreeMindMacro
  Redmine::WikiFormatting::Macros.register do
    desc "Displays freemind maindmap.\n\n"+
      "  !{{free_mind(file_name)}}\n\n" +
      "  !{{free_mind(file_name, width, hight)}}\n"
    macro :free_mind do |obj, args|
      return nil unless obj

      return nil if args.length == 0
      filename = args[0].strip
      baseurl = Redmine::Utils.relative_url_root
      attachment = Attachment.find(:first, :conditions => ['container_id = ? and filename = ?', obj, filename])
      raise "Attachment \"#{filename}\" not found." unless attachment

      target = url_for(:controller => 'attachments', :action => 'download', :id => attachment, :filename => attachment.filename )

      width = "100%"
      hight = "400px"

      width = "#{args[1].strip}" if args.length > 1
      hight = "#{args[2].strip}" if args.length > 2

      contentid = "flashcontent#{rand(10000)}"
      o =<<EOF
#{javascript_include_tag "flashobject.js", :plugin => "redmine_free_mind"}

<div id="#{contentid}">
  Flash plugin or Javascript are turned off.
  Activate both and reload to view the mindmap.
</div>
<script type="text/javascript">
  var fo = new FlashObject("#{baseurl}/plugin_assets/redmine_free_mind/visorFreemind.swf", "FreeMind#{contentid}", "#{width}", "#{hight}", 6, "#9999ff");
  fo.addParam("quality", "high");
  fo.addParam("bgcolor", "#ffffff");
  fo.addVariable("openUrl", "_blank");
  fo.addVariable("initLoadFile", "#{target}");
  fo.addVariable("startCollapsedToLevel","5");
  fo.write("#{contentid}");
</script>
EOF

      return o
    end
  end


end
