From: Rich Townsend <rhdt-OBnUx95tOyn10jlvfTC4gA@public.gmane.org>
Subject: Re: Re: Re: Smart Battery System driver
Date: Fri, 21 Jan 2005 12:06:54 -0500
Message-ID: <41F136AE.3010603@bartol.udel.edu>
References: <F760B14C9561B941B89469F59BA3A84708CBB988@orsmsx401.amr.corp.intel.com> <20050121141449.GA15288@message-id.gmane0305.slipkontur.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20050121141449.GA15288-l0tNAEGuAhhzZ8+rp42Dbp9+tswZ0GTaehPwdyo5hKaELgA04lAiVw@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Stefan Seyfried <seife-T+3qhDtrTvDv8lqoKu5MV4HBZQ1bDw0s@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Stefan Seyfried wrote:
> On Thu, Jan 20, 2005 at 02:04:16PM -0800, Grover, Andrew wrote:
> 
> 
>>Hasn't anyone written a libpower yet? Battery applets shouldn't be
>>groveling around proc, they should be making library calls. OK all
>>existing apps would need to be changed (probably a big code reduction
>>actually) but this would let the library look for both CM and sbs
>>interfaces (which should not pretend to be a CMBatt of course) and
>>handle them.
> 
> 
> Thomas Renninger has written a libpower on which his powersaved is based.
> It can be used without powersaved as well. It is hosted on
> http://forge.novell.com (search for powersaved) and on sourceforge
> (sorry, don't know the project name and right now i am offline, it probably
> is also named powersaved).
> 
> 
>>Bonus points for also supporting APM through this interface...
> 
> 
> Yes, it can use both without the application knowing what the underlying
> hardware is supporting.
> 
> Actually it is right now only extensively used and tested on SUSE, but
> we have some bugreports from people compiling it on Mandrake and Debian
> too, so it should not be too hard to get it going on other Distributions.

But aren't we really looking for a kernel-based libpower -- so that 
*nothing* in userspace needs be exposed to the specifics of the hardware?


-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
