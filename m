From: Felix Homann <fexpop-53koH/AXb86i2/dY4+mD5w@public.gmane.org>
Subject: Re: Centrino not scaling to lowest frequency
Date: Thu, 25 Aug 2005 17:04:50 +0200
Message-ID: <200508251704.50673.fexpop@onlinehome.de>
References: <200508152344.11572.fexpop@onlinehome.de> <200508181847.48291.fexpop@onlinehome.de> <20050824105002.GC12792@dominikbrodowski.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20050824105002.GC12792-X3ehHDuj6sIIGcDfoQAp7BvVK+yQ3ZXh@public.gmane.org>
Content-Disposition: inline
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
Cc: Dominik Brodowski <linux-X3ehHDuj6sIIGcDfoQAp7OTW4wlIGRCZ@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

On Wednesday 24 August 2005 12:50, Dominik Brodowski wrote:
> That's because other Operating Systems do "throttling" on top of "CPU
> frequency scaling", even though that doesn't save you any energy. The
> better energy usage rates of Windows are a known problem; hopefully the
> dynamic tick patch will improve the situation in this regard.
>
> 	Dominik
>

Thanks for the info. The dynamic tick patch sounds really interesting! I'll 
give it a try.

BTW, Intel's CPU identifiction utility reports a system bus frequency of 400 
MHz when the CPU is reported to work at 600 MHz. Usually the system bus is 
running at 533 MHz. Is this the effect of "throttling" on top of "CPU 
frequency scaling" or is this something different?

Thanks,

Felix


-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
