From: =?ISO-8859-1?Q?Robert_W=F6rle?= <robert.woerle-y2s3ugBAdl9BDgjK7y7TUQ@public.gmane.org>
Subject: Re: Tablet PC + 2.4.18 + acpi 20020726 + swsup11 working !
Date: Tue, 06 Aug 2002 16:32:43 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <3D4FDE0B.4020600@symplon.com>
References: <3D4F7B2A.2090602@symplon.com> <20020806091304.GA15963@poup.poupinou.org> <3D4FBB33.8070501@symplon.com> <200208061528.27394.joerg.sonnenberger@web.de> <20020806140043.GB16571@poup.poupinou.org>
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
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=acpi-devel>
To: Ducrot Bruno <ducrot-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>
Cc: =?ISO-8859-1?Q?J=F6rg_Sonnenberger?= <joerg.sonnenberger-S0/GAf8tV78@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Ducrot Bruno schrieb:

>On Tue, Aug 06, 2002 at 03:28:27PM +0200, Jörg Sonnenberger wrote:
>  
>
>>Am Dienstag, 6. August 2002 14:04 schrieb Robert Wörle:
>>    
>>
>>>So what is this pci1 and pic2 thing ??? and why is it residing at my
>>>wanted IO ???
>>>      
>>>
>>Let me guess: PIC = Programmable Interrupt Controller,
>>so I think you don't wanna mess with it! The interesting question is, why is 
>>your device in this range? This ports are reserved since the days of IBM's 
>>good old AT.
>>
>>    
>>
>
>Well, not all those ports are used by the original 8259A.  And the PIC 2, is
>'only' at range A0-AF, according to Ralf Brown list.  Linux extend it a little,
>but I don't know why.
>
>  
>
Tell me guys , what driver is this pic2 .. where can i found the 
according **.c to have some try`S and modify it
so if it doesnt need these ports then i can use them for my purposes ...


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
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
