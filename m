From: Matthew Garrett <mjg59-1xO5oi07KQx4cg9Nei1l7Q@public.gmane.org>
Subject: Re: Help with S3 on an Acer Travelmate c110 [SOLVED]
Date: Tue, 21 Jun 2005 22:22:48 +0100
Message-ID: <1119388968.11066.5.camel@tyrosine>
References: <42B43B7B.8000402@mindzion.com>
	 <200506191425.11398.stefandoesinger@gmx.at> <42B59E95.1070408@mindzion.com>
	 <200506192200.05982.stefandoesinger@gmx.at>
	 <20050620094248.GA3121@elf.ucw.cz> <42B6DF19.9020103@mindzion.com>
	 <20050620204515.GB1873@elf.ucw.cz> <1119353280.11066.0.camel@tyrosine>
	 <20050621204628.GC8899@poupinou.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20050621204628.GC8899-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Bruno Ducrot <ducrot-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>
Cc: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>, Adam Olsen <adamo-VDTgcPsuuaZWk0Htik3J/w@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Tue, 2005-06-21 at 22:46 +0200, Bruno Ducrot wrote:
> On Tue, Jun 21, 2005 at 12:28:00PM +0100, Matthew Garrett wrote:
> > Hmm. There /should/ be no difference between video_post and vbetool
> > post.
> > 
> 
> I see at least one: video_post allow architectures that are not i386.

Ah, yes, that's true. The Xorg people told me that vm86 was preferable
to x86emu on x86, but that doesn't help a great deal for amd64. I'll
port it at some stage.

-- 
Matthew Garrett | mjg59-1xO5oi07KQx4cg9Nei1l7Q@public.gmane.org



-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
