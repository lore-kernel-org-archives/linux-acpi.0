From: Erik Tews <erik-KVSZC2aA8+zw/snApU8qRLNAH6kLmebB@public.gmane.org>
Subject: Re: Radeon PM Support
Date: Wed, 04 Aug 2004 01:23:27 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1091575407.2956.2.camel@localhost.localdomain>
References: <1091139240.26511.9.camel@6-allhosts>
	 <20040730141028.GE21359@luna.mooo.com> <20040730162756.4f300a5c@localhost>
	 <20040730190047.GH21359@luna.mooo.com>
	 <1091560208.24759.15.camel@6-allhosts>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1091560208.24759.15.camel@6-allhosts>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Andrew Barr <barr.156-ZbGKxL/pcrQ@public.gmane.org>
Cc: Acpi Devel <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Am Di, den 03.08.2004 schrieb Andrew Barr um 21:10:
> My card came in the mail today...it works fine except for...(you guessed
> it) S3 suspend with a framebuffer. The card never re-initializes (even
> with acpi_sleep=s3_bios) and the monitor never powers back up. I can do
> swsusp2, which is okay for now, but I guess my question at this point is
> this: does anyone know what is keeping this card from working right with
> a framebuffer over S3? More to the point, it is something that could be
> fixed? Given how far the ACPI code has come in 2.6, I would certainly
> hope something is possible.
> 
> Andrew
> 
> P.S. In case you're wondering, yes, I'm a bit of a perfectionist. ;)

Well, I got a radeon 9600 too, and it never comes back too. I did not
try swsuspend or any special parameters. If you find a solution, please
tell me.

I heard that somebody has a t41p running with acpi, but I could't get my
system working with acpi here.



-------------------------------------------------------
This SF.Net email is sponsored by OSTG. Have you noticed the changes on
Linux.com, ITManagersJournal and NewsForge in the past few weeks? Now,
one more big change to announce. We are now OSTG- Open Source Technology
Group. Come see the changes on the new OSTG site. www.ostg.com
