From: Ville =?ISO-8859-1?Q?P=E4tsi?= <drc-dZkOyQknF4g@public.gmane.org>
Subject: Re: Acer 233xc dsdt table broken?
Date: 18 Jun 2003 14:41:37 +0300
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1055936497.3844.7.camel@corsair>
References: <1055928971.2970.14.camel@corsair>
	 <20030618112942.GF19556@poupinou.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20030618112942.GF19556-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Ducrot Bruno <ducrot-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Wed, 2003-06-18 at 14:29, Ducrot Bruno wrote: 
> > http://mail.ramk.fi/~drc/dsdt-acer-233xc.dsl.gz
> 
> A quick look at this asl show no support for S1 and there is
> no FAN device as well.

Odd considering that sleep works in windows. Maybe it's using S3 there? 

I just had an odd event where the temperature meter didn't seem to work
(in was stuck at 23C). The fan reacted like this was actually the case,
and the cpu heated to 80C, where the system shut down. After I restarted
the system the meter worked again, and the temperature was at 70C and
the fan was at full speed. The fan slowed down at two points, until the
cpu reached 50C, so seems it works properly. So maybe the fan isn't acpi
controlled?


-------------------------------------------------------
This SF.Net email is sponsored by: INetU
Attention Web Developers & Consultants: Become An INetU Hosting Partner.
Refer Dedicated Servers. We Manage Them. You Get 10% Monthly Commission!
INetU Dedicated Managed Hosting http://www.inetu.net/partner/index.php
