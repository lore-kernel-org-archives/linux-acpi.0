From: Stephan Krings <Stephan.Krings-Mmb7MZpHnFY@public.gmane.org>
Subject: Re: ACPI - SWSUSP interaction
Date: Thu, 8 May 2003 08:58:24 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <16058.16.254227.882114@hotzenplotz.chateau-neukoelln.de>
References: <Pine.LNX.4.21.0305071429500.7835-100000@vista.rtm.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <Pine.LNX.4.21.0305071429500.7835-100000-fIJwbSqd/OutujjWdiIZrQ@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Rob Miller <rob-7HoZ3oJp7ZtBDgjK7y7TUQ@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi,

> In any event, I think there is an issue that one or more folk here may be
> able to help with.  It appears to me that reads of at least the following
> /proc entries do not actually test the hardware state, but rely on
> detecting ACPI events to trigger changes in stored information:

[ ... ]

> Question 1:  Is my conclusion above accurate, or have I run into an
> idiosyncrasy of the laptop?

No, I can confirm your observation. I'm also using both ACPI and the
swsusp patches for 2.4. When the machine is suspended and the AC
adapter changes state, this change will not be recognized upon resume.

I'd guess that the ACPI code stores the state somewhere in memory and
will only change it, when the ACPI BIOS generates events.

I think the ACPI code should just reexamine some values after
resume. This will require quite a lot of integration between swsusp
and ACPI and I'm not sure, if this integration is already present.

Regards,

Stephan



-------------------------------------------------------
Enterprise Linux Forum Conference & Expo, June 4-6, 2003, Santa Clara
The only event dedicated to issues related to Linux enterprise solutions
www.enterpriselinuxforum.com
