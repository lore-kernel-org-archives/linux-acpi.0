From: Hiromichi Ito <itooon-ez3K6K0nqN9BPp5YB5Ev3w@public.gmane.org>
Subject: Re: [PATCH] Fix ACPI IRQ level weirdness
Date: Fri, 27 Sep 2002 16:02:14 +0900
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20020927070217.26709@po.lancenet.or.jp>
References: <Pine.LNX.4.44.0209261409380.28213-100000@dexter.groveronline.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-2022-JP"
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <Pine.LNX.4.44.0209261409380.28213-100000-SNx59YkgthvyYw2uXbqB2185lzT46atW@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchives/forum.php?forum=acpi-devel>
To: Andy Grover <agrover-qb8aLOKklSjp4P8CbLYnNQ@public.gmane.org>, acpi-devel-pyega4qmqnRoyOMFzWx49A@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi,

I am using 2.4.20-pre7 with acpi-20020918 patch and had become the same phenomenon.

I am using Xeon(enable HT) and E7500 chipset system [Supermicro P4DP8-G2].

>Could you please give this patch a go, and if it works, please apply?

Your patch works fine.
It stopped the phenomenon.

# Lance Inc.                R&D Division # 
# Hiromichi Ito  (itooon-ez3K6K0nqN9BPp5YB5Ev3w@public.gmane.org) #


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
