From: Carl-Daniel Hailfinger <c-d.hailfinger.devel.2005-hi6Y0CQ0nG0@public.gmane.org>
Subject: Re: [RFC] Reliable video POSTing on resume
Date: Sat, 05 Feb 2005 01:52:23 +0100
Message-ID: <420418C7.5010309@gmx.net>
References: <20050122134205.GA9354@wsc-gmbh.de>	 <e796392205020221387d4d8562@mail.gmail.com> <420217DB.709@gmx.net>	 <4202A972.1070003@gmx.net> <20050203225410.GB1110@elf.ucw.cz>	 <1107474198.5727.9.camel@desktop.cunninghams>	 <4202DF7B.2000506@gmx.net>	 <1107485504.5727.35.camel@desktop.cunninghams>	 <9e4733910502032318460f2c0c@mail.gmail.com>	 <20050204074454.GB1086@elf.ucw.cz> <9e473391050204093837bc50d3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
In-Reply-To: <9e473391050204093837bc50d3-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Jon Smirl <jonsmirl-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>, ncunningham-jjFNsPSvq+iXDw4h08c5KA@public.gmane.org, ACPI List <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Jon Smirl schrieb:
> On Fri, 4 Feb 2005 08:44:54 +0100, Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org> wrote:
> 
>>We already try to do that, but it hangs on 70% of machines. See
>>Documentation/power/video.txt.
> 
> We know that all of these ROMs are run at power on so they have to
> work. This implies that there must be something wrong with the
> environment the ROM are being run in. Video ROMs make calls into the
> INT vectors of the system BIOS. If these haven't been set up yet
> running the VBIOS is sure to hang.  Has someone with ROM source and
> the appropriate debugging tools tried to debug one of these hangs?
> Alternatively code could be added to wakeup.S to try and set these up
> or dump the ones that are there and see if they are sane.

My problem (Samsung P35) is that the BIOS wants to call code which
is no longer mapped because the BIOS is too big to fit into the
standard area. Since that additional area has been overwritten, we
are out of luck. Maybe if we did something like backing up all
untouched real mode memory immediately after switching to protected
mode, it could work. But I don't know whether that is feasible on
boot. Anyways, you don't want to run possibly buggy closed source
bios code in an environment where a single random memory write
may corrupt the kernel without debuggability.

And sometimes there is BIOS code which is can't be run twice.
Period.
Don't believe that one? I have a machine where calling EDD code
in the BIOS twice will hang the second time. See boot parameter
edd=off for reference :-(

So I agree that we could try to preserve the state better, but
I also can guarantee you it won't help everywhere.


Regards,
Carl-Daniel
-- 
http://www.hailfinger.org/


-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
