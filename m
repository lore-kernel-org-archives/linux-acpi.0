From: Stefan Seyfried <seife-T+3qhDtrTvDv8lqoKu5MV4HBZQ1bDw0s@public.gmane.org>
Subject: Re: [PATCH] take2: enable acpi_os_allocate() to allocate larger memory
Date: Tue, 24 May 2005 14:17:28 +0200
Message-ID: <20050524121728.GA29280@message-id.gmane0305.slipkontur.de>
References: <F7DC2337C7631D4386A2DF6E8FB22B300381628C@hdsmsx401.amr.corp.intel.com> <42931252.8000400@jp.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <42931252.8000400-+CUm20s59erQFUHtdCDX3A@public.gmane.org>
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

On Tue, May 24, 2005 at 08:38:58PM +0900, Kenji Kaneshige wrote:
> Hi,
> 
> Thank you for the information.
> 
> Please note that the failure of reading /proc/acpi/dsdt is
> just an example. I think there will be other cases that
> acpi_os_allocate() needs to allocate memory larger than the
> maximum allocation size of kmalloc(). For example, custom
> DSDT cannot be loaded on my machine without this patch. So
> I think we need this patch even if /proc/acpi/dsdt will be
> removed in the future.

But you should not override your DSDT!! You should get your vendor
to update the BIOS!!

Just kidding.
Sorry, i really could not resist ;-)
-- 
Stefan Seyfried



-------------------------------------------------------
This SF.Net email is sponsored by Yahoo.
Introducing Yahoo! Search Developer Network - Create apps using Yahoo!
Search APIs Find out how you can build Yahoo! directly into your own
Applications - visit http://developer.yahoo.net/?fr=offad-ysdn-ostg-q22005
