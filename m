From: Erik Tews <erik-KVSZC2aA8+zw/snApU8qRLNAH6kLmebB@public.gmane.org>
Subject: Re: Radeon PM Support
Date: Wed, 04 Aug 2004 03:33:36 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1091583216.2974.2.camel@localhost.localdomain>
References: <1091139240.26511.9.camel@6-allhosts>
	 <20040730141028.GE21359@luna.mooo.com> <20040730162756.4f300a5c@localhost>
	 <20040730190047.GH21359@luna.mooo.com>
	 <1091560208.24759.15.camel@6-allhosts>  <41103952.2030707@optonline.net>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <41103952.2030707-p32f3XyCuykqcZcGjlUOXw@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Nathan Bryant <nbryant-p32f3XyCuykqcZcGjlUOXw@public.gmane.org>
Cc: Andrew Barr <barr.156-ZbGKxL/pcrQ@public.gmane.org>, Acpi Devel <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Am Mi, den 04.08.2004 schrieb Nathan Bryant um 3:18:
> The problem is in the graphics driver. Unfortunately graphics drivers 
> are a bit of a mess on linux: there are multiple drivers that all may 
> think they "own" the device. There are non-DRI X drivers that don't 
> incorporate any kernel functionality, DRI-based drivers that do include 
> kernel components, the text console driver (which knows nothing about 
> specific hardware), the framebuffer drivers... one or all of those 
> drivers needs to be taught how to resume the card, and if more than one 
> driver is running at once, they need to coordinate resume functionality 
> amongst themselves.
> 
> Good luck getting the drivers talking amongt one another if one of them 
> is not open source...
> 
> Also there are issues with AGPGART not knowing how to resume certain AGP 
> bus chipsets.

Well, if somebody would have a configuration, like add this
framebuffer-support, drop this dri-driver, then it works, it would be
enough for me.



-------------------------------------------------------
This SF.Net email is sponsored by OSTG. Have you noticed the changes on
Linux.com, ITManagersJournal and NewsForge in the past few weeks? Now,
one more big change to announce. We are now OSTG- Open Source Technology
Group. Come see the changes on the new OSTG site. www.ostg.com
