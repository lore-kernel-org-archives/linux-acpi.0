From: Johan Vromans <jvromans-2pNSKKP3PSKEVqv0pETR8A@public.gmane.org>
Subject: Re: Centrino not scaling to lowest frequency
Date: Tue, 16 Aug 2005 10:44:54 +0200
Message-ID: <m2u0hqqni1.fsf@phoenix.squirrel.nl>
References: <200508152344.11572.fexpop@onlinehome.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <200508152344.11572.fexpop-53koH/AXb86i2/dY4+mD5w@public.gmane.org> (Felix Homann's
 message of "Mon, 15 Aug 2005 23:44:11 +0200")
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

Felix Homann <fexpop-53koH/AXb86i2/dY4+mD5w@public.gmane.org> writes:

> $ cat /sys/devices/system/cpu/cpu0/cpufreq/scaling_available_frequencies
> 1600000 1333000 1067000 800000

On my Acer Travelmate 4001WLMi the CPU frequencies in the DSDT were
wrong. Did you check you have the right DSDT and frequencies?

-- Johan

See also: http://www.squirrel.nl/people/jvromans/articles/TM4001WLMi/acpi/speedstep.html


-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
