From: Matthew Garrett <mjg59-1xO5oi07KQx4cg9Nei1l7Q@public.gmane.org>
Subject: Re: Re: Samsung P35 and S3 suspend
Date: Thu, 16 Dec 2004 21:10:02 +0000
Message-ID: <1103231402.5984.84.camel@tyrosine>
References: <41BFC3AD.5030001@gmx.net>
	 <200412161832.09711.stefandoesinger@gmx.at> <41C1D3CB.5010805@gmx.net>
	 <200412162157.02741.stefandoesinger@gmx.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <200412162157.02741.stefandoesinger-RbZlAiThDcE@public.gmane.org>
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

On Thu, 2004-12-16 at 21:57 +0100, Stefan D=C3=B6singer wrote:

> In the ideal case the frame buffer driver would run the VGA Rom post=20
> routine($0xc000:$3) in an X86 emulator(or in vm86 mode if it works), set =
up=20
> the frame buffer and at the end of the resume function the device is in t=
he=20
> same state where it was before suspend and user mode programs like the=20
> X-Server won't recognise that the system was suspended.
> That's at least my opinion.

It turns out that this works badly. A large number of machines have code
at c000:0003 that jumps to somewhere else in the video ROM - this
executes a small amount of code (normally turning off the screen) and
then jumps elsewhere. In laptop hardware, this second jump is often to
code that is no longer mapped into address space. I've seen several
machines where trying to run POST code under XFree's x86 emulator fails
because it suddenly hits a pile of binary that looks nothing like the
x86 instruction set.

(This is fairly easy to test, by the way - you can generally dump the
video rom by dding out of /dev/kmem. Disassemble it and work out where
it jumps to, and then disassemble that. Keep following it and you may
well end up discovering that it jumps out to code that you're not able
to get hold of)

POSTing will help in some cases (it seems to work well on Thinkpads),
but it's not a universal cure. I've had more joy with saving and
restoring the VBE state.

--=20
Matthew Garrett | mjg59-1xO5oi07KQx4cg9Nei1l7Q@public.gmane.org



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
