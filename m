From: Alan Cox <alan-qBU/x9rampVanCEyBjwyrvXRex20P6io@public.gmane.org>
Subject: Re: An embedded-Linux power-management framework
Date: 03 Aug 2002 00:29:11 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1028330951.31733.5.camel@irongate.swansea.linux.org.uk>
References: <20020802172802.GA32612@avalon.paulsen.org>
	<1028315477.18635.113.camel@irongate.swansea.linux.org.uk>
	<1028312475.23390.63.camel@granite.austin.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1028312475.23390.63.camel-j9xLUTenKzJXsEFxtoW7CMxtgHpCUUYS@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=acpi-devel>
To: Hollis Blanchard <hollis-V7BBcbaFuwjMbYB6QlFGEg@public.gmane.org>
Cc: "Robert C. Paulsen Jr." <robert-J3gkRE/D7QA8RZtLRHdnRF6hYfS7NtTn@public.gmane.org>, Linux Power Management Development <linux-pm-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, Linux ACPI Development <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, Linux APMD <apmd-list-+wEybqfU8vgCzWx7n4ubxQ@public.gmane.org>, CPU Frequency <cpufreq-1walMZg8u8rXmaaqVzeoHQ@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

On Fri, 2002-08-02 at 19:20, Hollis Blanchard wrote:
> There are situations (especially in dedicated-purpose devices running
> only a few hand-written applications) in which it helps to change some
> of these values without changing the others. Changing them all according
> to a single variable (CPU core frequency) could be very limiting. To my
> knowledge the cpufreq code also does not allow for this flexibility, but
> certainly it would be nice to add it.

So improve the cpufreq code to be a bit more controllable. Its the right
framework. It also needs a littlw tweaking for the cases where we change
STPCLK on x86's.




-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
