From: Alberto Ornaghi <alor-G/4Acn03FKk@public.gmane.org>
Subject: Re: Getting things clear.
Date: Fri, 27 Sep 2002 19:49:46 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <5.1.0.14.2.20020927194816.02cba8e0@wheresmymailserver.com>
References: <20020927162855.GA1806@geolandia.home>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20020927162855.GA1806-CwhMdJBTcbtgNr7TIQy98w@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchives/forum.php?forum=acpi-devel>
To: antonio-OL5acaPONM41GQ1Ptb7lUw@public.gmane.org
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

At 18.28 27-09-2002, Antonio G. - Geotronix wrote:

>I seem to understand that a good acpi implementation (including swsusp)
>is done by applying the following patches to 2.4.18 kernel (as there's
>non swsusp for 2.4.19):
>
>*) kacpid.patch

not needed anymore.
this patch is needed by presario 7xx family if you use the acpi patch prior 
to 20020918.
with the latest the SCI is handled properly

bye

    --==> ALoR <==---------------------- -  -   -

There are only 10 types of people in this world...
those who understand binary, and those who don't.



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
