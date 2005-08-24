From: Dominik Brodowski <linux-X3ehHDuj6sIIGcDfoQAp7OTW4wlIGRCZ@public.gmane.org>
Subject: Re: Centrino not scaling to lowest frequency
Date: Wed, 24 Aug 2005 12:50:02 +0200
Message-ID: <20050824105002.GC12792@dominikbrodowski.de>
References: <200508152344.11572.fexpop@onlinehome.de> <20050816080625.GE9150@dominikbrodowski.de> <200508181847.48291.fexpop@onlinehome.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <200508181847.48291.fexpop-53koH/AXb86i2/dY4+mD5w@public.gmane.org>
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

Hi,

On Thu, Aug 18, 2005 at 06:47:48PM +0200, Felix Homann wrote:
> On the other hand, in Windows I _do_ get 600 MHz without any further trickery. 
> And at 600 MHz it seems to give me a lot more battery life, too. How does 
> that work?

That's because other Operating Systems do "throttling" on top of "CPU
frequency scaling", even though that doesn't save you any energy. The better
energy usage rates of Windows are a known problem; hopefully the dynamic
tick patch will improve the situation in this regard.

	Dominik


-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
