From: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
Subject: Re: Re: Call for help: list of machines with working S3
Date: Wed, 4 May 2005 18:31:59 +0200
Message-ID: <20050504163159.GA2377@elf.ucw.cz>
References: <20050214211105.GA12808@elf.ucw.cz> <200503140719.01536.lkml@kcore.org> <20050314080029.GF22635@elf.ucw.cz> <200503141539.14018.lkml@kcore.org> <8764y356o8.fsf@gismo.pca.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <8764y356o8.fsf-vpnYUZh4Q8kL5bzFcGmneg@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
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

Hi!

> Sorry for the late reply, but I made some more tests before.
> 
> On Mon 14 Mar 2005 15:39 +0100, Jan De Luyck wrote:
> > On Monday 14 March 2005 09:00, Pavel Machek wrote:
> >> Hi!
> >>
> >> >   * MySQL (hinders the actual suspension process and kicks the pc back to
> >> >     where it was)
> >>
> >> Try this patch...
> >
> > Works nicely. Thanks.
> 
> The same happened to me on 2.6.12-rc2, once applied the patch, but
> I've been using a plain 2.6.12-rc3 for 5 days and I'm getting S3 and
> S4 without any problem on an IBM ThinkPad T42p (S3 with
> acpi_sleep=s3_bios, as previously reported).
> 
> So, question: is this bug completely solved? In this case, the two
> bugs [1] and [2] should be closed ;-)

It is not... I have a patch but don't know why it works => bad, not
going to mainline.

								Pavel

-- 
Boycott Kodak -- for their patent abuse against Java.


-------------------------------------------------------
This SF.Net email is sponsored by: NEC IT Guy Games.
Get your fingers limbered up and give it your best shot. 4 great events, 4
opportunities to win big! Highest score wins.NEC IT Guy Games. Play to
win an NEC 61 plasma display. Visit http://www.necitguy.com/?r=20
