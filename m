From: Fionn Behrens <fionn-ZPjJJ+sDHmfddJNmlsFzeA@public.gmane.org>
Subject: RE: Acer Notebook: acpi IRQ stuck after S3
Date: Thu, 13 Jan 2005 10:31:02 +0100
Message-ID: <1105608662.14488.106.camel@laptop>
References: <16A54BF5D6E14E4D916CE26C9AD30575FB1EF6@pdsmsx402.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <16A54BF5D6E14E4D916CE26C9AD30575FB1EF6-4yWAQGcml66iAffOGbnezLfspsVTdybXVpNB7YpNyf8@public.gmane.org>
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

On Thu 13.01.2005, 09:09 +0800 Li, Shaohua wrote:
> Hi,
> >log and backtrace:
> >
> >12:49:00 samt kernel: irq 9: nobody cared!
> >12:49:00 samt kernel: Disabling IRQ #9
> >
> >As you can see, IRQ 9 gets stuck here and consequently, the next ACPI
> >event (e.g. lid button) causes a system freeze.

> Did any device share IRQ 9 with ACPI? If yes, please try unload the
> driver.

No, according to /proc/interrupts, IRQ 9 is being used by acpi
exclusively.

any other ideas?

br,
	Fionn
-- 
Software patents    -  not allowed in Europe | See whats going on:
Archiving Email     -  patented in Europe    | http://freepatents.org/
E-Shopping Baskets  -  patented in Europe    | Become active easily:
Cross-compiling     -  patented in Europe    | http://aktiv.ffii.org/eubsa/en




-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
