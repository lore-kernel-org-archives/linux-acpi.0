From: Stefan =?utf-8?q?D=C3=B6singer?= <stefandoesinger-RbZlAiThDcE@public.gmane.org>
Subject: Re: Re: Samsung P35 and S3 suspend
Date: Thu, 16 Dec 2004 22:26:43 +0100
Message-ID: <200412162226.43166.stefandoesinger@gmx.at>
References: <41BFC3AD.5030001@gmx.net> <200412162157.02741.stefandoesinger@gmx.at> <1103231402.5984.84.camel@tyrosine>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1103231402.5984.84.camel@tyrosine>
Content-Disposition: inline
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
Cc: Matthew Garrett <mjg59-1xO5oi07KQx4cg9Nei1l7Q@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

> It turns out that this works badly. A large number of machines have code
> at c000:0003 that jumps to somewhere else in the video ROM - this
> executes a small amount of code (normally turning off the screen) and
> then jumps elsewhere. In laptop hardware, this second jump is often to
> code that is no longer mapped into address space. I've seen several
> machines where trying to run POST code under XFree's x86 emulator fails
> because it suddenly hits a pile of binary that looks nothing like the
> x86 instruction set.
This is partially true for my system. The instruction at c000:0003 is a JMP. 
But the code seems to remain in the area around 0xc0000. A jump somewhere 
else is a good explanation for the crashes on some machines.

Is this code used by the system bios to boot the VGA card when powering on the 
machine?

> POSTing will help in some cases (it seems to work well on Thinkpads),
> but it's not a universal cure. I've had more joy with saving and
> restoring the VBE state.
Is this the vbestate utility? I'll have a look at it. What does 
vm86_video_post do? It looks like another lrmi based "call c000:0003 
utility". Can only saving and restoring the VBE state bring the card back to 
live or do I need to call the reset routine in any case?

Stefan


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
