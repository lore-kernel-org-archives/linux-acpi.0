From: David Fox <david.fox-77kvfFC2TplBDgjK7y7TUQ@public.gmane.org>
Subject: Re: ACPI Suspend support
Date: Thu, 06 Mar 2003 07:29:20 -0800
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <3E676950.6050209@lindows.com>
References: <20030306120556.17cd0ef1.g.zwartjes@student.tue.nl> <20030306113153.GA11760@enigma.daemon.sh>
Mime-Version: 1.0
Content-Type: multipart/alternative;
 boundary="------------080102050204050105070104"
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Sebastian Henschel <shensche-1rjuZeEg9oEb1SvskN2V4Q@public.gmane.org>
Cc: Gertjan <g.zwartjes-oe7qfRrRQfdlL9U78CI+FQ@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org


--------------080102050204050105070104
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

I'm thinking of going to the 2.5 kernels to get the ACPI S3 support, but 
I'm having trouble with devfs, which seems to be not quite working in 
the 2.5 series from my reading of kernel-devel.  Has this been resolved? 
 Anyone out there using devfs in a 2.5 kernel?

Sebastian Henschel wrote:

>heyho...
>
>Received at 2003-03-06 / 12:19 by Gertjan:
>  
>
>>I was wondering if suspend support for ACPI is already implemented. Which
>>kernel must I use if I want my laptop to support suspending. My laptop is
>>an ASUS L3400D with a SiS chip set in it. It has no support for APM so I
>>really would like to have support for suspend-to-RAM. Can somebody tell me
>>what versions to use, or if it is still unsupported.
>>    
>>
>
>take one of the recent 2.5.x kernels if you really need it. but i cannot
>say if it will work for your laptop. :)
>
>with kernel 2.4.x you maybe can have standby (S1) with the acpi-patch
>and suspend-to-disk (S4) with the swsusp-patch
>(http://fchabaud.free.fr/English/default.php3?COUNT=3&FILE0=Tricks&FILE1=Laptop&FILE2=Swsusp). but no suspend-to-ram (S3) as far as i know.
>
>  
>
>>Please correct me if I am asking this question in the wrong mailing-list.
>>The reason I am posting it here is that I am inquiring the stage of
>>development...
>>    
>>
>
>that is okay, acpi4linux is still under heavy development, so the border
>between devel and user is very thin (though i would have posted it in
>acpi-support).
>
>cheers,
> sebastian
>  
>


--------------080102050204050105070104
Content-Type: text/html; charset=us-ascii
Content-Transfer-Encoding: 7bit

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
  <title></title>
</head>
<body>
I'm thinking of going to the 2.5 kernels to get the ACPI S3 support, but
I'm having trouble with devfs, which seems to be not quite working in the
2.5 series from my reading of kernel-devel. &nbsp;Has this been resolved? &nbsp;Anyone
out there using devfs in a 2.5 kernel?<br>
<br>
Sebastian Henschel wrote:<br>
<blockquote type="cite"
 cite="mid20030306113153.GA11760-adzhR0EPeY/7X6WiDY61Ug@public.gmane.org">
  <pre wrap="">heyho...

Received at 2003-03-06 / 12:19 by Gertjan:
  </pre>
  <blockquote type="cite">
    <pre wrap="">I was wondering if suspend support for ACPI is already implemented. Which
kernel must I use if I want my laptop to support suspending. My laptop is
an ASUS L3400D with a SiS chip set in it. It has no support for APM so I
really would like to have support for suspend-to-RAM. Can somebody tell me
what versions to use, or if it is still unsupported.
    </pre>
  </blockquote>
  <pre wrap=""><!---->
take one of the recent 2.5.x kernels if you really need it. but i cannot
say if it will work for your laptop. :)

with kernel 2.4.x you maybe can have standby (S1) with the acpi-patch
and suspend-to-disk (S4) with the swsusp-patch
(<a class="moz-txt-link-freetext" href="http://fchabaud.free.fr/English/default.php3?COUNT=3&FILE0=Tricks&FILE1=Laptop&FILE2=Swsusp">http://fchabaud.free.fr/English/default.php3?COUNT=3&amp;FILE0=Tricks&amp;FILE1=Laptop&amp;FILE2=Swsusp</a>). but no suspend-to-ram (S3) as far as i know.

  </pre>
  <blockquote type="cite">
    <pre wrap="">Please correct me if I am asking this question in the wrong mailing-list.
The reason I am posting it here is that I am inquiring the stage of
development...
    </pre>
  </blockquote>
  <pre wrap=""><!---->
that is okay, acpi4linux is still under heavy development, so the border
between devel and user is very thin (though i would have posted it in
acpi-support).

cheers,
 sebastian
  </pre>
</blockquote>
<br>
</body>
</html>

--------------080102050204050105070104--



-------------------------------------------------------
This SF.net email is sponsored by: Etnus, makers of TotalView, The debugger 
for complex code. Debugging C/C++ programs can leave you feeling lost and 
disoriented. TotalView can help you find your way. Available on major UNIX 
and Linux platforms. Try it free. www.etnus.com
