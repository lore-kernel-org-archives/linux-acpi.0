From: Luca Capello <luca-wlebWZzHoyE@public.gmane.org>
Subject: Re: Re: 2.6.9 S4: clock not updated after resume
Date: Sat, 23 Oct 2004 19:49:40 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <417A99B4.40707@pca.it>
References: <4177A9DC.7060503@pca.it> <20041021202051.GA21624@elf.ucw.cz> <4178C072.1020905@pca.it> <loom.20041023T170041-953@post.gmane.org>
Reply-To: ML ACPI-devel <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <loom.20041023T170041-953-eS7Uydv5nfjZ+VzJOa5vwg@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: ML ACPI-devel <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hello,

on 10/23/04 17:03, Jon Valvatne wrote:
> Maybe I'm missing something here, but if the problem is that the
> kernel doesn't update the system clock from the hardware clock on
> resume, why bother with NTP? Can't you just do a hwclock --hctosys?
well, I never did it because I didn't know this command, I'll try
tomorrow and report :-)

> Of course, the proper way is for the kernel to do it, I'm just saying..
As Pavel stated, it's a kernel bug, but the fix he posted didn't worked
on my machine.

Thx, bye,
Gismo / Luca
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)
Comment: Using GnuPG with Debian - http://enigmail.mozdev.org

iD8DBQFBepmzVAp7Xm10JmkRAp+lAJ9DMZvJtdx7vUb2LXhqJL9WGdhXKQCcDLL0
8R6A2lvpZ6xzFi+Bu+QRtKU=
=uzPn
-----END PGP SIGNATURE-----


-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
