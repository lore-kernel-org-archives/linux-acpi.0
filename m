From: Norbert Preining <preining-DX+603jRYB8@public.gmane.org>
Subject: Re: Re: various problems with Acer TM654, suspend, ACAD, radeon
Date: Mon, 23 Aug 2004 12:35:15 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20040823103515.GH8635@gamma.logic.tuwien.ac.at>
References: <20040820161911.GA24510@gamma.logic.tuwien.ac.at> <20040823070534.GD24853@message-id.gmane0305.slipkontur.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 8bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20040823070534.GD24853-l0tNAEGuAhhzZ8+rp42Dbp9+tswZ0GTaehPwdyo5hKaELgA04lAiVw@public.gmane.org>
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

Hi Stefan! Hi list!

On Mon, 23 Aug 2004, Stefan Seyfried wrote:
> > With S2D I had success up to 2.6.7-mm5 (I didn't check all the inbetween
> > kernels), but with 2.6.8.1-mmX and rc4-mmX the laptop suspends without
> > any problems (besides I have to stop mysqld), even with X running (ATI
> > Radeon 7500M 0000:01:00.0 VGA compatible controller: ATI Technologies
> > Inc Radeon Mobility M7 LW [Radeon Mobility 7500]).
> > 
> > With the newer kernels resuming does not work anymore, there are many
> 
> cat /sys/power/disk ??

sys mem disk

> does "echo -n shutdown > /sys/power/disk" prior to suspending help?

no, not really. And I found that it may be the b44 driver, because this
one Ooops when resuming. I will try to capture the syslog output ..

I also see that the writing process of data to swap is much slower than
prior to the pmdisk/swsusp merge.

> > - Same with the AC Adapter, why does it send no event at all?
> 
> Acer notebooks are notorious for these errors. Don't know if the hardware
> or only the DSDT are just full of sh**

Thanks to the previous posters I fixed this and posted a fixed dsdt
table to acpi.sf.net. See also www.logic.at/people/preining/acer

Best wishes

Norbert

-------------------------------------------------------------------------------
Norbert Preining <preining AT logic DOT at>         Technische Universität Wien
gpg DSA: 0x09C5B094      fp: 14DF 2E6C 0307 BE6D AD76  A9C0 D2BF 4AA3 09C5 B094
-------------------------------------------------------------------------------
ARDSCALPSIE (n.)
Excuse made by rural Welsh hairdresser for completely massacring your
hair.
			--- Douglas Adams, The Meaning of Liff


-------------------------------------------------------
SF.Net email is sponsored by Shop4tech.com-Lowest price on Blank Media
100pk Sonic DVD-R 4x for only $29 -100pk Sonic DVD+R for only $33
Save 50% off Retail on Ink & Toner - Free Shipping and Free Gift.
http://www.shop4tech.com/z/Inkjet_Cartridges/9_108_r285
