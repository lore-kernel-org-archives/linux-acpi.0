From: Robert Woerle <robert.woerle-y2s3ugBAdl9BDgjK7y7TUQ@public.gmane.org>
Subject: Re: hibernate
Date: Mon, 04 Nov 2002 15:02:55 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <3DC67E0F.5010408@symplon.com>
References: <20021104133736.GA16301@Tonelli.sns.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: mennucc1-8fiUuRrzOP0dnm+yROfE0A@public.gmane.org
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

In the 2.4.X tree there will be no S3 nor S4 functionlity ... only the 
2.5.x are about to have that working...
but what you can do is apply the swsusp patch then you get a hibernate 
at S4

btw hibernate is S4 ! S3 is the standby ( suspend to ram )

Andrea Mennucc schrieb:

>hi
>
>I would like to hibernate my Asus notebook
>
>I use Debian 3.0
>
>I have compiled kernel-image 2.4.19 with acpi patches 
>acpi-20020821-2.4.19.diff.gz
>
>I have tried 
>$ echo S3 > /proc/acpi/sleep
>or
>$ echo 3 > /proc/acpi/sleep
>(which I have seen in a e-mail somewhere) but to no effect
>
>
>what else should I do? can someone point me to relevant information?
>
>ps:  have seen today that there are more recent patches; I will compile
> them and try them
>
>
>thanks
>
>a.
>
>
>  
>

-- 
 
_____________________________________
*Robert Wörle
 Linux | Embedded Device*
*
Symplon AG*

*...touch the internet*

phone: +49 89 552 999 35
fax: +49 89 552 999 10
email: robert.woerle-y2s3ugBAdl9BDgjK7y7TUQ@public.gmane.org <mailto:robert.woerle@symplon.com>
web: www.symplon.com <http://www.symplon.com/>

_____________________________________
 



-------------------------------------------------------
This SF.net email is sponsored by: ApacheCon, November 18-21 in
Las Vegas (supported by COMDEX), the only Apache event to be
fully supported by the ASF. http://www.apachecon.com
