From: Marci <voloterreno-nc/lrvXPQ4s@public.gmane.org>
Subject: Re: [Fwd: ACPI error when trying entring in Sleep Mode]
Date: Tue, 18 Mar 2003 15:10:04 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <3E7728BC.70704@tin.it>
References: <20030317134809.GF8319@poup.poupinou.org> <3E75D6E2.4040001@tin.it> <20030317153147.GH8319@poup.poupinou.org> <3E7611EB.2050805@tin.it> <20030317184333.GL8319@poup.poupinou.org> <3E761BFA.9030609@tin.it> <3E762BDD.8030108@hp.com> <3E762DED.70301@tin.it> <3E763453.1080307@hp.com> <3E7648C3.9090402@tin.it> <20030318094752.GO8319@poup.poupinou.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20030318094752.GO8319-j6u/t2rXLliUoIHC/UFpr9i2O/JbrIOy@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Ducrot Bruno <ducrot-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>
Cc: Richard Black <richard.black-VXdhtT5mjnY@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Ducrot Bruno wrote:

>On Mon, Mar 17, 2003 at 11:14:27PM +0100, Marci wrote:
>  
>
>>Richard Black wrote:
>>
>>    
>>
>
>...
>
>  
>
>>Errors:
>>
>>In file included from osl.c:205:
>>/home/melchior/dsdt.hex:333: field name not in record or union initializer
>>/home/melchior/dsdt.hex:333: (near initialization for `AmlCode')
>>In file included from osl.c:205:
>>/home/melchior/dsdt.hex:333:68: warning: multi-line string literals are 
>>deprecated
>>    
>>
>
>This patch is not updated to the 'big struct change' that was
>done in mid-january.
>
>You have to replace all the
>acpi_table_header
>with:
>struct acpi_table_header
>
>or alternatively look at http://www.poupinou.org/acpi/
>for more instruction.
>
>Please note that I am in process to debug more your ASL.
>
>I will point you to the correct diff, etc. when I finished, and
>will comment you all the change done (but, I'm a human being,
>you known, and I may be slow sometimes...).
>
>Cheers,
>
>  
>
Nope, I've tried all the suggestions, but without results , the same 
errors , I post the errors that I've encountred this time, but I think 
that are the same:

In file included from osl.c:28:
/boot/dsdt_table.h:333: field name not in record or union initializer
/boot/dsdt_table.h:333: (near initialization for `AmlCode')
In file included from osl.c:28:
/boot/dsdt_table.h:333:68: warning: multi-line string literals are 
deprecated
/boot/dsdt_table.h:333: warning: initialization makes integer from 
pointer without a cast
/boot/dsdt_table.h:333: initializer element is not computable at load time
/boot/dsdt_table.h:333: (near initialization for `AmlCode[2552]')
/boot/dsdt_table.h:333: syntax error before "SBRGPIX0"
/boot/dsdt_table.h:334:68: warning: multi-line string literals are 
deprecated
/boot/dsdt_table.h:335:68: warning: multi-line string literals are 
deprecated
/boot/dsdt_table.h:336:68: warning: multi-line string literals are 
deprecated
/boot/dsdt_table.h:337:68: warning: multi-line string literals are 
deprecated
/boot/dsdt_table.h:333: syntax error at '#' token
/boot/dsdt_table.h:338:68: warning: multi-line string literals are 
deprecated
/boot/dsdt_table.h:339:68: warning: multi-line string literals are 
deprecated
/boot/dsdt_table.h:340:68: warning: multi-line string literals are 
deprecated
/boot/dsdt_table.h:341:68: warning: multi-line string literals are 
deprecated
/boot/dsdt_table.h:342:68: warning: multi-line string literals are 
deprecated
/boot/dsdt_table.h:343:68: warning: multi-line string literals are 
deprecated
/boot/dsdt_table.h:333: invalid suffix on integer constant
/boot/dsdt_table.h:344:68: warning: multi-line string literals are 
deprecated
/boot/dsdt_table.h:333: invalid suffix on floating constant
/boot/dsdt_table.h:345:68: warning: multi-line string literals are 
deprecated
/boot/dsdt_table.h:346:68: warning: multi-line string literals are 
deprecated
/boot/dsdt_table.h:347:68: warning: multi-line string literals are 
deprecated
/boot/dsdt_table.h:348:68: warning: multi-line string literals are 
deprecated
/boot/dsdt_table.h:349:68: warning: multi-line string literals are 
deprecated
/boot/dsdt_table.h:350:68: warning: multi-line string literals are 
deprecated
/boot/dsdt_table.h:351:68: warning: multi-line string literals are 
deprecated
/boot/dsdt_table.h:352:68: warning: multi-line string literals are 
deprecated
/boot/dsdt_table.h:353:68: warning: multi-line string literals are 
deprecated
/boot/dsdt_table.h:354:68: warning: multi-line string literals are 
deprecated
/boot/dsdt_table.h:355:68: warning: multi-line string literals are 
deprecated
/boot/dsdt_table.h:356:68: warning: multi-line string literals are 
deprecated
/boot/dsdt_table.h:357:68: warning: multi-line string literals are 
deprecated
/boot/dsdt_table.h:358:68: warning: multi-line string literals are 
deprecated
/boot/dsdt_table.h:359:68: warning: multi-line string literals are 
deprecated
/boot/dsdt_table.h:360:68: warning: multi-line string literals are 
deprecated
/boot/dsdt_table.h:361:67: warning: multi-line string literals are 
deprecated
/boot/dsdt_table.h:362:68: warning: multi-line string literals are 
deprecated
/boot/dsdt_table.h:363:68: warning: multi-line string literals are 
deprecated
/boot/dsdt_table.h:364:68: warning: multi-line string literals are 
deprecated
/boot/dsdt_table.h:365:68: warning: multi-line string literals are 
deprecated
/boot/dsdt_table.h:366:67: warning: multi-line string literals are 
deprecated
/boot/dsdt_table.h:367:68: warning: multi-line string literals are 
deprecated
/boot/dsdt_table.h:368:68: warning: multi-line string literals are 
deprecated
/boot/dsdt_table.h:369:68: warning: multi-line string literals are 
deprecated
/boot/dsdt_table.h:370:68: warning: multi-line string literals are 
deprecated
/boot/dsdt_table.h:371:68: warning: multi-line string literals are 
deprecated
/boot/dsdt_table.h:372:68: warning: multi-line string literals are 
deprecated
/boot/dsdt_table.h:373:68: warning: multi-line string literals are 
deprecated
/boot/dsdt_table.h:333: syntax error at '#' token
/boot/dsdt_table.h:374:68: warning: multi-line string literals are 
deprecated
/boot/dsdt_table.h:375:68: warning: multi-line string literals are 
deprecated
/boot/dsdt_table.h:376:68: warning: multi-line string literals are 
deprecated
/boot/dsdt_table.h:377:68: warning: multi-line string literals are 
deprecated
/boot/dsdt_table.h:378:68: warning: multi-line string literals are 
deprecated
/boot/dsdt_table.h:379:68: warning: multi-line string literals are 
deprecated
/boot/dsdt_table.h:380:68: warning: multi-line string literals are 
deprecated
/boot/dsdt_table.h:381:68: warning: multi-line string literals are 
deprecated
/boot/dsdt_table.h:382:68: warning: multi-line string literals are 
deprecated
/boot/dsdt_table.h:383:68: warning: multi-line string literals are 
deprecated
/boot/dsdt_table.h:384:68: warning: multi-line string literals are 
deprecated
make[4]: *** [osl.o] Error 1
make[3]: *** [first_rule] Error 2
make[2]: *** [_subdir_acpi] Error 2
make[1]: *** [_dir_drivers] Error 2
make: *** [stamp-build] Error 2


Bye and thanks again for the time that you loose for me






-------------------------------------------------------
This SF.net email is sponsored by: Does your code think in ink? 
You could win a Tablet PC. Get a free Tablet PC hat just for playing. 
What are you waiting for?
http://ads.sourceforge.net/cgi-bin/redirect.pl?micr5043en
