From: Stefan Seyfried <seife-T+3qhDtrTvDv8lqoKu5MV4HBZQ1bDw0s@public.gmane.org>
Subject: Re: Re: Smart Battery System driver
Date: Fri, 21 Jan 2005 15:14:49 +0100
Message-ID: <20050121141449.GA15288@message-id.gmane0305.slipkontur.de>
References: <F760B14C9561B941B89469F59BA3A84708CBB988@orsmsx401.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <F760B14C9561B941B89469F59BA3A84708CBB988-sBd4vmA9Se6krb+BlOpmy7fspsVTdybXVpNB7YpNyf8@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Thu, Jan 20, 2005 at 02:04:16PM -0800, Grover, Andrew wrote:

> Hasn't anyone written a libpower yet? Battery applets shouldn't be
> groveling around proc, they should be making library calls. OK all
> existing apps would need to be changed (probably a big code reduction
> actually) but this would let the library look for both CM and sbs
> interfaces (which should not pretend to be a CMBatt of course) and
> handle them.

Thomas Renninger has written a libpower on which his powersaved is based.
It can be used without powersaved as well. It is hosted on
http://forge.novell.com (search for powersaved) and on sourceforge
(sorry, don't know the project name and right now i am offline, it probably
is also named powersaved).

> Bonus points for also supporting APM through this interface...

Yes, it can use both without the application knowing what the underlying
hardware is supporting.

Actually it is right now only extensively used and tested on SUSE, but
we have some bugreports from people compiling it on Mandrake and Debian
too, so it should not be too hard to get it going on other Distributions.
-- 
Stefan Seyfried



-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
