From: Stefan =?iso-8859-15?q?D=F6singer?= <stefandoesinger-RbZlAiThDcE@public.gmane.org>
Subject: Re: S3 broken Samsung P35 - howto debug?
Date: Thu, 25 Nov 2004 14:03:02 +0100
Message-ID: <200411251403.02800.stefandoesinger@gmx.at>
References: <200411211600.01820.od@fet.uni-hannover.de> <200411242221.45175.stefandoesinger@gmx.at> <1101364915.7151.5.camel@mhcln03>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1101364915.7151.5.camel@mhcln03>
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
To: Matthias Hentges <mailinglisten-H4PcyxPeSRnR7s880joybQ@public.gmane.org>
Cc: Oliver Dawid <oliver-csNNzRR391izQB+pC5nmwQ@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

> I just tried it. It works in MS-DOS :) I guess there is still hope.
> When I run it, the monitor goes out, coming back a second later with a
> message about a BIOS IIRC.
What does this message look like? Maybe it can give a clue why boot-radeon 
doesn't work.

> Now the question is: why the hell doesn't boot_radeon work, it's using
> the same addresses AFAICS. Maybe a problem with lrmi? hmmm
Did you try Ole Rohne's kernel patch? It is a hack that switches to real 
mode(real real mode, not vm86 or emulated 8086 mode)?

> I wish I could, but that's beyond my abilities :( I don't speak C or
> ASM, I'm afraid.
> If you really finish this project some time, it's going to the *the*
> killer app for
> Radeon laptops.
I'm afraid you'll have to wait until christmas, when I have the next school 
holidays. I am quite busy now.

The danger is that it really becomes a killer. As I said, I just copied 
assembler code to C code without really knowing what it does. So I do not 
recommend it until someone from ATI has a look at it. So far I haven't mailed 
ATI, and I do not think I'll get help from them. Ole predicted the answer 
"Use the bios"

Stefan


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
