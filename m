From: Karol Kozimor <sziwan-DETuoxkZsSqrDJvtcaxF/A@public.gmane.org>
Subject: Re: Fujitsu Lifebook P2120 S3 sleep: progress report + patch
Date: Fri, 28 Feb 2003 17:52:00 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20030228165200.GB862@hell.org.pl>
References: <ebw1y1swmjv.fsf@pcedu3.cern.ch> <20030228141510.GA24824@hell.org.pl> <ebwwujkv46p.fsf@pcedu3.cern.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <ebwwujkv46p.fsf-e5kh7Nd5fja2ozzinb8jHw@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Ole Rohne <ole.rohne-vJEk5272eHo@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Thus wrote Ole Rohne:
> > Actually, 8139too works fine after S3 resume, at least on my machine -
> > tested on 2.5.6[13]. Takes several seconds to get responding, but works.
> Which version of the chip do you have? - there is a comment in the
> code about bringing old chips out of low-power mode, which I guess
> doesn't work on chips with PCI Power Management capabilities (eg
> version 10).

Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8139/8139C/8139C+
(rev 10)

It does work, because ssh is the only way I can get my keyboard working 
(i.e. by reloading the modules).
Best regards,

-- 
Karol 'sziwan' Kozimor
sziwan-DETuoxkZsSqrDJvtcaxF/A@public.gmane.org


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
