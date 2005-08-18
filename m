From: Felix Homann <fexpop-53koH/AXb86i2/dY4+mD5w@public.gmane.org>
Subject: Re: Centrino not scaling to lowest frequency
Date: Thu, 18 Aug 2005 18:47:48 +0200
Message-ID: <200508181847.48291.fexpop@onlinehome.de>
References: <200508152344.11572.fexpop@onlinehome.de> <20050816080625.GE9150@dominikbrodowski.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20050816080625.GE9150-X3ehHDuj6sIIGcDfoQAp7BvVK+yQ3ZXh@public.gmane.org>
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

Hi

in the meantime I found out that although my system claims (sticker) to 
contain a Pentium M 725  (a Dothan) in fact is does contain a Pentium M 730J 
(a Sonoma). 

A look into Intel's documentation 30220913.pdf then reveals (Table 1) a Lowest 
Freq. Mode at 800 MHz. Hence it seems that Dominik is right and my CPU 
doesn't support 600 MHz  (if I get it right). So everything seems to be OK.

On the other hand, in Windows I _do_ get 600 MHz without any further trickery. 
And at 600 MHz it seems to give me a lot more battery life, too. How does 
that work?

(Actually, I initially wondered why Windows reported so much more battery time 
as opposed to Linux, and then found out that Windows can run the CPU at 600 
MHz.) 

Furthermore, are there really only 4 frequencies specified for the Sonoma?

Thanks again,

Felix

On Tuesday 16 August 2005 10:06, Dominik Brodowski wrote:
> > Can anybody give me a hint how to get to 600 MHz on my system?
>
> The patched DSDT does not provide the necessary values for 600MHz --
> possibly because your CPU does not support 600 MHz.
>
> 	Dominik


-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
