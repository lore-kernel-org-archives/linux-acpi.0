From: Marci <voloterreno-nc/lrvXPQ4s@public.gmane.org>
Subject: Re: [Fwd: ACPI error when trying entring in Sleep Mode]
Date: Tue, 18 Mar 2003 15:58:31 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <3E773417.3030601@tin.it>
References: <20030317153147.GH8319@poup.poupinou.org> <3E7611EB.2050805@tin.it> <20030317184333.GL8319@poup.poupinou.org> <3E761BFA.9030609@tin.it> <3E762BDD.8030108@hp.com> <3E762DED.70301@tin.it> <3E763453.1080307@hp.com> <3E7648C3.9090402@tin.it> <20030318094752.GO8319@poup.poupinou.org> <3E7728BC.70704@tin.it> <20030318141933.GU8319@poup.poupinou.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20030318141933.GU8319-j6u/t2rXLliUoIHC/UFpr9i2O/JbrIOy@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Ducrot Bruno <ducrot-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Ducrot Bruno wrote:

>On Tue, Mar 18, 2003 at 03:10:04PM +0100, Marci wrote:
>  
>
>>Ducrot Bruno wrote:
>>
>>    
>>
>>Nope, I've tried all the suggestions, but without results , the same 
>>errors , I post the errors that I've encountred this time, but I think 
>>that are the same:
>>    
>>
>
>...
>
>  
>
>>Bye and thanks again for the time that you loose for me
>>
>>    
>>
>
>Just receive when I wrote to you to say that I finished..
>
>Could you try
>ftp://ftp.poupinou.org/acpi/MSI/MSI_KT4_Ultra.hex.bz2
>
>with instruction at http://www.poupinou.org/acpi/over.html
>
>hope that will work this time!
>
>Cheers
>
>  
>
Nothing, in truth I don't know what I should do . I've used the .hex 
file found in that FTP, but the problem is the same.  The kernel doesn't 
accept the file :-(
Same errors.
Bho.
Where I make my mistake?
I 've took the file, ad renamed in the /boot directory as dsdt_table.h , 
then I've uncompressed the kernel, applied the 2.4.21-pre4 patch and the 
ACPI patch for this kernel, then I've applied the osl.c patch (It say 
"Hunk succeded" , so I think that is ok) and then I configure and 
recompile it. And appears this error.





-------------------------------------------------------
This SF.net email is sponsored by: Does your code think in ink? 
You could win a Tablet PC. Get a free Tablet PC hat just for playing. 
What are you waiting for?
http://ads.sourceforge.net/cgi-bin/redirect.pl?micr5043en
