# Free Mind plugin for Redmine
# Copyright (C) 2010  Takashi Takebayashi
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
require 'free_ming_macro'

Redmine::Plugin.register :redmine_free_mind do
  name 'Redmine Free Mind plugin'
  author 'Takashi Takebayashi'
  description 'This is a Free Mind plugin for Redmine'
  version '1.0.0'
  requires_redmine :version_or_higher => '1.0.0'

  project_module :free_mind do
    permission :view_free_mind, {:free_mind => [:index]}, :require => :member
    permission :add_free_mind, {:free_mind => [:new]}, :require => :member
  end
end
