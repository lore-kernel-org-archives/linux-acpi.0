From: Marci <voloterreno-nc/lrvXPQ4s@public.gmane.org>
Subject: Re: [Fwd: ACPI error when trying entring in Sleep Mode]
Date: Mon, 17 Mar 2003 23:14:27 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <3E7648C3.9090402@tin.it>
References: <3E75C4A6.6000507@tin.it> <20030317134809.GF8319@poup.poupinou.org> <3E75D6E2.4040001@tin.it> <20030317153147.GH8319@poup.poupinou.org> <3E7611EB.2050805@tin.it> <20030317184333.GL8319@poup.poupinou.org> <3E761BFA.9030609@tin.it> <3E762BDD.8030108@hp.com> <3E762DED.70301@tin.it> <3E763453.1080307@hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <3E763453.1080307-VXdhtT5mjnY@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Richard Black <richard.black-VXdhtT5mjnY@public.gmane.org>
Cc: Ducrot Bruno <ducrot-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Richard Black wrote:

> Make sure what your current directory is: run the command "pwd"
> Then look at the beginning of the osl.diff file: "head /tmp/osl.diff"
> The basic command is:
>
> patch -p0 /tmp/osl.diff
>
> Increase the -p# number for each of the directories you want patch to 
> ignore.
>
> Here's another way you can do this:
>
> Look at the diff file (also called patch file) to see the number of 
> directories listed, then change directory so that you are now in the 
> same directory as the "osl" file that you need to patch. Then if there 
> are (in the patch file) 3 directories (for example: +++ 
> Blah/Blah/Blah/osl), then run patch -p3 /tmp/osl.diff which will 
> ignore all those 3 directories and will concentrate on updating only 
> the osl file.
>
> Otherwise if this isn't the problem, then I would need to see the 
> output from running the patch command.
>
> Marci wrote:
>
>> Richard Black wrote:
>>
>>> If anyone is having a problem with the documentation then the 
>>> documentation may need to be updated. In the meantime, here's the 
>>> info on how to use patch:
>>>
>>> http://www.cpqlinux.com/patch.html
>>>
>>> I believe all that they are saying with the line:
>>>
>>> "patch -p1 /PATH/TO/osl.diff and Customize the path to dstl.hex"
>>>
>>> is that /PATH/TO/osl.diff needs to point to the os1.diff file 
>>> (wherever you have it stored) so if you have it in your /tmp 
>>> directory then this would look like
>>>
>>> patch -p1 /tmp/osl.diff
>>>
>>>
>>> Marci wrote:
>>>
>>>> I'me very sorry to disturb you another time , but I need help for a 
>>>> thing.
>>>>
>>>> I've read the instructions on how to override the DSDT table by 
>>>> recompiling the linux kernel, but I've not understood clearly the 
>>>> process. In the part when it say that I have to make "patch -p1 
>>>> /PATH/TO/osl.diff and Customize the path to dstl.hex" (the part 
>>>> denominated "How to teach the kernel to use your costum table" )
>>>>
>>>> Thanks again for the help
>>>>
>>>> Marcello
>>>>
>>>>
>>>>
>>>> -------------------------------------------------------
>>>> This SF.net email is sponsored by:Crypto Challenge is now open! Get 
>>>> cracking and register here for some mind boggling fun and the 
>>>> chance of winning an Apple iPod:
>>>> http://ads.sourceforge.net/cgi-bin/redirect.pl?thaw0031en
>>>> _______________________________________________
>>>> Acpi-devel mailing list
>>>> Acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
>>>> https://lists.sourceforge.net/lists/listinfo/acpi-devel
>>>
>>>
>>>
>>>
>>>
>> Ok, I've done this, but when I compile the kernel it says a lot of 
>> errors about dsdt.hex in very much lines. What is wrong :(
>>
>>
>>
>>
>>
>
Ok, I've patched the file osl.c (manually , because the patch found in 
that page doesn't want work ) but I think that I've done a good work 
(i've followed the instructions in the patch file, I've changed only the 
lines that were changed ) . The problem is in recompile the kernel, I 
get these messages.

Thank for your help

Errors:

In file included from osl.c:205:
/home/melchior/dsdt.hex:333: field name not in record or union initializer
/home/melchior/dsdt.hex:333: (near initialization for `AmlCode')
In file included from osl.c:205:
/home/melchior/dsdt.hex:333:68: warning: multi-line string literals are 
deprecated
/home/melchior/dsdt.hex:333: warning: initialization makes integer from 
pointer without a cast
/home/melchior/dsdt.hex:333: initializer element is not computable at 
load time
/home/melchior/dsdt.hex:333: (near initialization for `AmlCode[2552]')
/home/melchior/dsdt.hex:333: syntax error before "SBRGPIX0"
/home/melchior/dsdt.hex:334:68: warning: multi-line string literals are 
deprecated
/home/melchior/dsdt.hex:335:68: warning: multi-line string literals are 
deprecated
/home/melchior/dsdt.hex:336:68: warning: multi-line string literals are 
deprecated
/home/melchior/dsdt.hex:337:68: warning: multi-line string literals are 
deprecated
/home/melchior/dsdt.hex:333: syntax error at '#' token
/home/melchior/dsdt.hex:338:68: warning: multi-line string literals are 
deprecated
/home/melchior/dsdt.hex:339:68: warning: multi-line string literals are 
deprecated
/home/melchior/dsdt.hex:340:68: warning: multi-line string literals are 
deprecated
/home/melchior/dsdt.hex:341:68: warning: multi-line string literals are 
deprecated
/home/melchior/dsdt.hex:342:68: warning: multi-line string literals are 
deprecated
/home/melchior/dsdt.hex:343:68: warning: multi-line string literals are 
deprecated
/home/melchior/dsdt.hex:333: invalid suffix on integer constant
/home/melchior/dsdt.hex:344:68: warning: multi-line string literals are 
deprecated
/home/melchior/dsdt.hex:333: invalid suffix on floating constant
/home/melchior/dsdt.hex:345:68: warning: multi-line string literals are 
deprecated
/home/melchior/dsdt.hex:346:68: warning: multi-line string literals are 
deprecated
/home/melchior/dsdt.hex:347:68: warning: multi-line string literals are 
deprecated
/home/melchior/dsdt.hex:348:68: warning: multi-line string literals are 
deprecated
/home/melchior/dsdt.hex:349:68: warning: multi-line string literals are 
deprecated
/home/melchior/dsdt.hex:350:68: warning: multi-line string literals are 
deprecated
/home/melchior/dsdt.hex:351:68: warning: multi-line string literals are 
deprecated
/home/melchior/dsdt.hex:352:68: warning: multi-line string literals are 
deprecated
/home/melchior/dsdt.hex:353:68: warning: multi-line string literals are 
deprecated
/home/melchior/dsdt.hex:354:68: warning: multi-line string literals are 
deprecated
/home/melchior/dsdt.hex:355:68: warning: multi-line string literals are 
deprecated
/home/melchior/dsdt.hex:356:68: warning: multi-line string literals are 
deprecated
/home/melchior/dsdt.hex:357:68: warning: multi-line string literals are 
deprecated
/home/melchior/dsdt.hex:358:68: warning: multi-line string literals are 
deprecated
/home/melchior/dsdt.hex:359:68: warning: multi-line string literals are 
deprecated
/home/melchior/dsdt.hex:360:68: warning: multi-line string literals are 
deprecated
/home/melchior/dsdt.hex:361:67: warning: multi-line string literals are 
deprecated
/home/melchior/dsdt.hex:362:68: warning: multi-line string literals are 
deprecated
/home/melchior/dsdt.hex:363:68: warning: multi-line string literals are 
deprecated
/home/melchior/dsdt.hex:364:68: warning: multi-line string literals are 
deprecated
/home/melchior/dsdt.hex:365:68: warning: multi-line string literals are 
deprecated
/home/melchior/dsdt.hex:366:67: warning: multi-line string literals are 
deprecated
/home/melchior/dsdt.hex:367:68: warning: multi-line string literals are 
deprecated
/home/melchior/dsdt.hex:368:68: warning: multi-line string literals are 
deprecated
/home/melchior/dsdt.hex:369:68: warning: multi-line string literals are 
deprecated
/home/melchior/dsdt.hex:370:68: warning: multi-line string literals are 
deprecated
/home/melchior/dsdt.hex:371:68: warning: multi-line string literals are 
deprecated
/home/melchior/dsdt.hex:372:68: warning: multi-line string literals are 
deprecated
/home/melchior/dsdt.hex:373:68: warning: multi-line string literals are 
deprecated
/home/melchior/dsdt.hex:333: syntax error at '#' token
/home/melchior/dsdt.hex:374:68: warning: multi-line string literals are 
deprecated
/home/melchior/dsdt.hex:375:68: warning: multi-line string literals are 
deprecated
/home/melchior/dsdt.hex:376:68: warning: multi-line string literals are 
deprecated
/home/melchior/dsdt.hex:377:68: warning: multi-line string literals are 
deprecated
/home/melchior/dsdt.hex:378:68: warning: multi-line string literals are 
deprecated
/home/melchior/dsdt.hex:379:68: warning: multi-line string literals are 
deprecated
/home/melchior/dsdt.hex:380:68: warning: multi-line string literals are 
deprecated
/home/melchior/dsdt.hex:381:68: warning: multi-line string literals are 
deprecated
/home/melchior/dsdt.hex:382:68: warning: multi-line string literals are 
deprecated
/home/melchior/dsdt.hex:383:68: warning: multi-line string literals are 
deprecated
/home/melchior/dsdt.hex:384:68: warning: multi-line string literals are 
deprecated
make[4]: *** [osl.o] Error 1
make[3]: *** [first_rule] Error 2
make[2]: *** [_subdir_acpi] Error 2
make[1]: *** [_dir_drivers] Error 2
make: *** [stamp-build] Error 2





-------------------------------------------------------
This SF.net email is sponsored by:Crypto Challenge is now open! 
Get cracking and register here for some mind boggling fun and 
the chance of winning an Apple iPod:
http://ads.sourceforge.net/cgi-bin/redirect.pl?thaw0031en
