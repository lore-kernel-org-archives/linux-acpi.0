From: Alan Cox <alan-qBU/x9rampVanCEyBjwyrvXRex20P6io@public.gmane.org>
Subject: Re: An embedded-Linux power-management framework
Date: 03 Aug 2002 14:40:09 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1028382009.31733.32.camel@irongate.swansea.linux.org.uk>
References: <OF94EF243F.A49E95B4-ON86256C09.00716EF4@pok.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <OF94EF243F.A49E95B4-ON86256C09.00716EF4-yJlKWOkj9xhBDgjK7y7TUQ@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=acpi-devel>
To: Bishop Brock <bcbrock-r/Jw6+rmf7HQT0dZR+AlfA@public.gmane.org>
Cc: Linux Power Management Development <linux-pm-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, Linux ACPI Development <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, Linux APMD <apmd-list-+wEybqfU8vgCzWx7n4ubxQ@public.gmane.org>, CPU Frequency <cpufreq-1walMZg8u8rXmaaqVzeoHQ@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

On Sat, 2002-08-03 at 02:28, Bishop Brock wrote:m
> We are proposing a scalable solution that naturally extends the
> capabilities of cpufreq. We encapsulate all of the mutually constrained
> physical and abstract parameters of a power management policy into
> a system-dependent object called an "operating point", and propose
> standard ways to manipulate operating points and sets of operating points.
> This mechanism will be integrated with the device model in such a way
> that as devices come on and off line, the optimum operating point is always
> available.

Each operating point being some appropriate categorised and chip
supported combination of power state ? So for something simple like a
mobile K6 we'd have something like

			Full on
			STPCLK and Powernow combinations
			hlt

> We also add another dimension not present in the current solution, i.e.,
> kernel control of dynamic power management at critical points in the
> OS, particularly the entry and exit of the idle (halt) state, consistent

You install your own idle handler to replace the default one - there are
some examples of people doing this already. The amd76x_pm code for
example installs its own idle handler which is needed because both
processors must be idle to drop into most powersaving states.

> with policies defined in advance.  As we noted in the original posting,
> significant system-wide energy savings are possible by rapidly scaling
> frequencies during even short idle periods, and only the OS has the
> visibility required to actively manage these events.

Clearly true



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
