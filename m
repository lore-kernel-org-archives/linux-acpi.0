From: John Belmonte <jvb-ZFKsivP1bGvOQU1ULcgDhA@public.gmane.org>
Subject: Re: Toshiba 5200-801 ACPI
Date: Mon, 03 Mar 2003 09:53:59 -0500
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <3E636C87.3060307@prairienet.org>
References: <1046664590.3e62d58e40b81@webmail.alunetworks.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1046664590.3e62d58e40b81-2RFepEojUI3JntwrmyXZtoQr+Ex5tWwz@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: erubboli-yZ7cK5sl2baEK/hMebVsMw@public.gmane.org, acpi-devel <acpi-devel-pyega4qmqnRoyOMFzWx49A@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Hello,

Please post your questions to the acpi-devel mailing list 
(acpi-devel-pyega4qmqnRoyOMFzWx49A@public.gmane.org).  I don't maintain the linux acpi system, only a 
small special extension for Toshiba laptops.

-John


erubboli-yZ7cK5sl2baEK/hMebVsMw@public.gmane.org wrote:
> Hello, i have a Toshiba 5200-801 and i have patched the kernel version 2.4.20 
> with ACPI support (from acpi.sourceforge.net). 
> I have compiled the basic support into the kernel and any other features 
> (battery, processor, toshiba etc..) as module. 
> In /proc filesystem all seems to be correct, i can view any information about 
> the system, but the kacpidpc kernel process crashes continuosly  
> look this shell log: 
>  
> erubboli@dpj:~$  ps afx | grep kacpidpc 
> 19559 ?        Z      0:00  \_ [kacpidpc <defunct>] 
> 19560 ?        Z      0:00  \_ [kacpidpc <defunct>] 
>  (after 2 seconds) 
> erubboli@dpj:~$ ps afx | grep kacpidpc 
> 27777 ?        Z      0:00  \_ [kacpidpc <defunct>] 
> 27778 ?        Z      0:00  \_ [kacpidpc <defunct>] 
>  
> have you some idea about this ?  
> What can I do for help you to help me ? ;) 
>  
> I don't know nothing about acpi... :( 
>  
> Thanks, 
>   Enrico Rubboli. 
>  
> --  
> Enrico Rubboli @ ALU Networks | Spring Italia 
> enrico-yZ7cK5sl2baEK/hMebVsMw@public.gmane.org 
> 
> -------------------------------------------------
> This mail sent through IMP: http://horde.org/imp/
> 


-- 
http:// if   l .   /



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
