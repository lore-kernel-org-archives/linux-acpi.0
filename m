From: Stefan Seyfried <seife-T+3qhDtrTvDv8lqoKu5MV4HBZQ1bDw0s@public.gmane.org>
Subject: Re: various problems with Acer TM654, suspend, ACAD, radeon
Date: Mon, 23 Aug 2004 09:05:34 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20040823070534.GD24853@message-id.gmane0305.slipkontur.de>
References: <20040820161911.GA24510@gamma.logic.tuwien.ac.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20040820161911.GA24510-DqSSrKF0TaySnEC3TeqHn5dqbFPxfnh/@public.gmane.org>
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

On Fri, Aug 20, 2004 at 06:19:11PM +0200, Norbert Preining wrote:

> With S2D I had success up to 2.6.7-mm5 (I didn't check all the inbetween
> kernels), but with 2.6.8.1-mmX and rc4-mmX the laptop suspends without
> any problems (besides I have to stop mysqld), even with X running (ATI
> Radeon 7500M 0000:01:00.0 VGA compatible controller: ATI Technologies
> Inc Radeon Mobility M7 LW [Radeon Mobility 7500]).
> 
> With the newer kernels resuming does not work anymore, there are many

cat /sys/power/disk ??
does "echo -n shutdown > /sys/power/disk" prior to suspending help?

> Now my questions:
> - Can the missing battery (dis)charge rate be fixed? Is this an hardware
>   defect, i.e. the battery does not send the information, or are there
>   other reasons?
> - Same with the AC Adapter, why does it send no event at all?

Acer notebooks are notorious for these errors. Don't know if the hardware
or only the DSDT are just full of sh**
-- 
Stefan Seyfried



-------------------------------------------------------
SF.Net email is sponsored by Shop4tech.com-Lowest price on Blank Media
100pk Sonic DVD-R 4x for only $29 -100pk Sonic DVD+R for only $33
Save 50% off Retail on Ink & Toner - Free Shipping and Free Gift.
http://www.shop4tech.com/z/Inkjet_Cartridges/9_108_r285
