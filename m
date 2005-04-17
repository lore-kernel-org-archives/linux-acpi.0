From: Johan Braennlund <johan_brn-/E1597aS9LQAvxtiuMwx3w@public.gmane.org>
Subject: Re: Savage backlight control
Date: Sat, 16 Apr 2005 21:49:13 -0700 (PDT)
Message-ID: <20050417044913.86969.qmail@web50207.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: 6667
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


Hi! Thanks for indulging me. If you don't mind, I have a last round of
questions.

--- Matthew Garrett <mjg59-1xO5oi07KQx4cg9Nei1l7Q@public.gmane.org> wrote:

> It's quite likely that your machine will have acpi methods to control
> the brightness, and if it does you could hook them up to the /proc
> interface. 

Okay. I disassembled the DSDT and there were a few LCD-related things
but AML doesn't make enough sense to me to be able to figure out what
they do. For anyone curious, I've put the DSDT at
http://nullinfinity.org/dsdt.dsl

I also discovered the kernel option CONFIG_BACKLIGHT_LCD_SUPPORT but 
all that seemed to do was to give me an empty directory
/sys/class/backlight/ and I'm not sufficiently familiar with the kernel
to figure out the reason for this. Do you know anything about this?

Finally: from what I understand, the Fn key combinations are handled by
the BIOS. How much work would it be to disassemble the BIOS to see
exactly how the brightness keys are handled?

Regards,

Johan



		
__________________________________ 
Do you Yahoo!? 
Plan great trips with Yahoo! Travel: Now over 17,000 guides!
http://travel.yahoo.com/p-travelguide


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
