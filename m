From: Johan Vromans <jvromans-2pNSKKP3PSKEVqv0pETR8A@public.gmane.org>
Subject: Re: Centrino speedstep
Date: Wed, 29 Dec 2004 19:49:19 +0100
Message-ID: <m2vfalc53k.fsf@phoenix.squirrel.nl>
References: <m2zmzyw4e7.fsf@phoenix.squirrel.nl>
	<20041228212653.GA8436@dominikbrodowski.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20041228212653.GA8436-X3ehHDuj6sIIGcDfoQAp7BvVK+yQ3ZXh@public.gmane.org> (Dominik
 Brodowski's message of "Tue, 28 Dec 2004 22:26:53 +0100")
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
Cc: Dominik Brodowski <linux-X3ehHDuj6sIIGcDfoQAp7BvVK+yQ3ZXh@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Dominik Brodowski <linux-X3ehHDuj6sIIGcDfoQAp7BvVK+yQ3ZXh@public.gmane.org> writes:

> It looks like your notebook's BIOS does not report sufficient data to the
> speedstep-centrino cpufreq driver. Does the acpi-cpufreq driver work
> instead?

The acpi-cpufreq driver loads, and the cpufreq tools seem to do
something. But do they actually work? E.g. cpufreq-info reports that
the limits are 1.6G - 600M, and cpufreq-set accepts 1.6G (confirmed by
/proc/cpuinfo) but my CPU is only 1.5G...

-- Johan



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
