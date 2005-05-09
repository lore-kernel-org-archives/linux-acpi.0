From: Matthew Garrett <mjg59-1xO5oi07KQx4cg9Nei1l7Q@public.gmane.org>
Subject: Re: Re: Resume -> higher power drain?
Date: Mon, 09 May 2005 14:47:39 +0100
Message-ID: <1115646459.27560.10.camel@elrond.flymine.org>
References: <427CC869.1050506@kernelconcepts.de>
	 <427CC869.1050506@kernelconcepts.de> <427CC9B3.7060005@gmx.net>
	 <427CC869.1050506@kernelconcepts.de> <427CC9B3.7060005@gmx.net>
	 <1115475297.10424.4.camel@localhost>
	 <20050507144417.GA3100@isilmar.linta.de>
	 <427CDE7B.5040306@kernelconcepts.de> <427CE3EF.1010005@kernelconcepts.de>
	 <20050507200225.GB8212@elf.ucw.cz>
	 <20050509090724.GA7781@message-id.gmane0305.slipkontur.de>
	 <1115643194.15912.41.camel@sponge.fungus>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1115643194.15912.41.camel-7g89Hwo0MwsWlyYapE9R8Q@public.gmane.org>
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

On Mon, 2005-05-09 at 14:53 +0200, Henrik Brix Andersen wrote:
> On Mon, 2005-05-09 at 11:07 +0200, Stefan Seyfried wrote:
> > That said, a recent X.org radeon driver should post the card, bring the light
> > back on (it does on my Dell D600) and make vbetool unnecessary on ATI radeon
> > chipsets
> 
> How recent? Does this driver also turn off the backlight during S3?

Unlikely. At the moment, X doesn't know that the system is suspending.

-- 
Matthew Garrett | mjg59-1xO5oi07KQx4cg9Nei1l7Q@public.gmane.org



-------------------------------------------------------
This SF.Net email is sponsored by: NEC IT Guy Games.
Get your fingers limbered up and give it your best shot. 4 great events, 4
opportunities to win big! Highest score wins.NEC IT Guy Games. Play to
win an NEC 61 plasma display. Visit http://www.necitguy.com/?r=20
