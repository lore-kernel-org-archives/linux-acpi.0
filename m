From: Nathan Bryant <nbryant-p32f3XyCuykqcZcGjlUOXw@public.gmane.org>
Subject: Re: Radeon PM Support
Date: Tue, 03 Aug 2004 21:18:10 -0400
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <41103952.2030707@optonline.net>
References: <1091139240.26511.9.camel@6-allhosts>
 <20040730141028.GE21359@luna.mooo.com> <20040730162756.4f300a5c@localhost>
 <20040730190047.GH21359@luna.mooo.com> <1091560208.24759.15.camel@6-allhosts>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7BIT
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-reply-to: <1091560208.24759.15.camel@6-allhosts>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Andrew Barr <barr.156-ZbGKxL/pcrQ@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Andrew Barr wrote:

>My card came in the mail today...it works fine except for...(you guessed
>it) S3 suspend with a framebuffer. The card never re-initializes (even
>with acpi_sleep=s3_bios) and the monitor never powers back up. I can do
>swsusp2, which is okay for now, but I guess my question at this point is
>this: does anyone know what is keeping this card from working right with
>a framebuffer over S3? More to the point, it is something that could be
>fixed? Given how far the ACPI code has come in 2.6, I would certainly
>hope something is possible.
>  
>
The problem is in the graphics driver. Unfortunately graphics drivers 
are a bit of a mess on linux: there are multiple drivers that all may 
think they "own" the device. There are non-DRI X drivers that don't 
incorporate any kernel functionality, DRI-based drivers that do include 
kernel components, the text console driver (which knows nothing about 
specific hardware), the framebuffer drivers... one or all of those 
drivers needs to be taught how to resume the card, and if more than one 
driver is running at once, they need to coordinate resume functionality 
amongst themselves.

Good luck getting the drivers talking amongt one another if one of them 
is not open source...

Also there are issues with AGPGART not knowing how to resume certain AGP 
bus chipsets.

>P.S. In case you're wondering, yes, I'm a bit of a perfectionist. ;)
>  
>
Sounds like we have a volunteer to clean up the whole mess :-)


-------------------------------------------------------
This SF.Net email is sponsored by OSTG. Have you noticed the changes on
Linux.com, ITManagersJournal and NewsForge in the past few weeks? Now,
one more big change to announce. We are now OSTG- Open Source Technology
Group. Come see the changes on the new OSTG site. www.ostg.com
