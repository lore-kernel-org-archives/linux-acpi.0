From: Dominik Brodowski <linux-X3ehHDuj6sIIGcDfoQAp7OTW4wlIGRCZ@public.gmane.org>
Subject: Re: Centrino not scaling to lowest frequency
Date: Tue, 16 Aug 2005 10:06:25 +0200
Message-ID: <20050816080625.GE9150@dominikbrodowski.de>
References: <200508152344.11572.fexpop@onlinehome.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <200508152344.11572.fexpop-53koH/AXb86i2/dY4+mD5w@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Felix Homann <fexpop-53koH/AXb86i2/dY4+mD5w@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Mon, Aug 15, 2005 at 11:44:11PM +0200, Felix Homann wrote:
> Hi,
> 
> on my Acer Extensa 4100 (BIOS S3C11) with a 1.60GHz Centrino I'm running a 
> custom Linux kernel 2.6.12.3 with acpi-dsdt-patch applied and the custom DSDT 
> "ACER-Aspire_1691WLMi-S3C11-custom.asl" from acpi.sourceforge.net.
> 
> Almost everything is working fine, except that the CPU can't be scaled down to 
> 600 MHz as it should (should it?).
> 
> Can anybody give me a hint how to get to 600 MHz on my system?

The patched DSDT does not provide the necessary values for 600MHz --
possibly because your CPU does not support 600 MHz.

	Dominik


-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
