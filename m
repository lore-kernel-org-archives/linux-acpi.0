From: Alimin Bijosono Oei <alimin-rdE3vRTOlSC6c6uEtOJ/EA@public.gmane.org>
Subject: Re: dsdt patch
Date: Wed, 04 Feb 2004 01:46:07 +1100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <401FB42F.10501@ihug.com.au>
References: <401CCB50.6010003@ihug.com.au> <401E12BC.60905@pca.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <401E12BC.60905-wlebWZzHoyE@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Luca Capello <luca-wlebWZzHoyE@public.gmane.org>
Cc: ML ACPI-devel <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Luca Capello wrote:

> Hello,
> 
> on 02/01/04 10:48, Alimin Bijosono Oei wrote:
> 
>>Just want to ask where can I find a patch that will allow me to use my
>>own dsdt for kernel 2.4.24? Is there such a patch flying around or is
>>the kernel itself patched to allow implementation of custom dsdt table?
> 
> there's an HOWTO here (even if against linux-2.4.18):
> 	http://www.cpqlinux.com/acpi-howto.html
> 
> Thx, bye,
> Gismo / Luca

Thanks Luca. That's what I have been following as well. But then I am 
stuck with the step of patching osl.c in order to include my own dsdt 
table. The howto had a patch for kernel 2.4.18 but what about 2.4.24 
which I am using now? Is there any osl.c patch for 2.4.24 somewhere?




-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
