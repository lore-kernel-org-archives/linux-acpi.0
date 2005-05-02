From: Matthew Garrett <mjg59-1xO5oi07KQx4cg9Nei1l7Q@public.gmane.org>
Subject: Re: Re: Re: Suspend2ram on Toshiba Tecra A3 OR problem with
	S3 on new 915PM chipset system appears to be with SATA/IDE
Date: Mon, 02 May 2005 10:32:08 +0100
Message-ID: <1115026328.7884.6.camel@tyrosine>
References: <200504272244.j3RMibEf032018@fnapcf.fnal.gov>
	 <20050428154326.GA9097@message-id.gmane0305.slipkontur.de>
	 <20050429074321.GA10475@srcf.ucam.org>
	 <20050501093804.GC10764@message-id.gmane0305.slipkontur.de>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20050501093804.GC10764-l0tNAEGuAhhzZ8+rp42Dbp9+tswZ0GTaehPwdyo5hKaELgA04lAiVw@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Stefan Seyfried <seife-T+3qhDtrTvDv8lqoKu5MV4HBZQ1bDw0s@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Sun, 2005-05-01 at 11:38 +0200, Stefan Seyfried wrote:
> On Fri, Apr 29, 2005 at 08:43:22AM +0100, Matthew Garrett wrote:
> > round to supporting them - I'm coming up against a lot of hardware which 
> > doesn't successfully resume IDE.
> 
> ...the driver need to do its own housekeeping anyway (flush queues before
> suspend etc) which was definitely _not_ done in the SATA drivers.
> BTW: at least with suspend to disk, i have not seen a broken PATA driver for
> quite some time.

The issue is that there doesn't seem to be any code to program the IDE
controller from scratch. This isn't an issue with suspend to disk,
because the BIOS has set it up correctly to begin with. This isn't
always the case with suspend to RAM.

-- 
Matthew Garrett | mjg59-1xO5oi07KQx4cg9Nei1l7Q@public.gmane.org



-------------------------------------------------------
This SF.Net email is sponsored by: NEC IT Guy Games.
Get your fingers limbered up and give it your best shot. 4 great events, 4
opportunities to win big! Highest score wins.NEC IT Guy Games. Play to
win an NEC 61 plasma display. Visit http://www.necitguy.com/?r=20
