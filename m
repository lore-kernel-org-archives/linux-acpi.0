From: roychris <roychris-GANU6spQydw@public.gmane.org>
Subject: Re: Re: psmouse.c, throwing 3 bytes away
Date: Mon, 09 Feb 2004 13:43:35 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <40278077.5070409@free.fr>
References: <20040208215935.GA13280@ucw.cz> <20040208221933.92D0B3F1B@latitude.mynet.no-ip.org> <20040208230314.GA21937@fubini.pci.uni-heidelberg.de> <20040208233052.GA17570@ucw.cz>
Mime-Version: 1.0
Content-Type: multipart/alternative;
 boundary="------------020504090203080602070609"
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20040208233052.GA17570-+ZI9xUNit7I@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Vojtech Pavlik <vojtech-AlSwsSmVLrQ@public.gmane.org>
Cc: Bernd Schubert <Bernd.Schubert-ZRyP5vvp4SQZDP5dtiX3a0ZMdOyQQXjt@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

This is a multi-part message in MIME format.
--------------020504090203080602070609
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by esstin.uhp-nancy.fr id i19CjuJa019494

I resolved this problem. It's the fault of the multiplexing on i8042.=20
You must pass i8042_nomux=3D1 to the kernel for 2.4.X or 2.6.0 or you mus=
t=20
modify
linux-2.6.x/drivers/input/serio/i8042.c by quoting many lines if > 2.6.0=20
because nomux doesn't work :


/*      if (!i8042_noaux && !i8042_check_aux(&i8042_aux_values)) {
                if (!i8042_nomux && !i8042_check_mux(&i8042_aux_values))
                        for (i =3D 0; i < 4; i++) {
                                i8042_init_mux_values(i8042_mux_values +=20
i, i804
2_mux_port + i, i);
                                i8042_port_register(i8042_mux_values +=20
i, i8042_
mux_port + i);
                        }
                else
*/                   =20
             i8042_port_register(&i8042_aux_values, &i8042_aux_port);
//      }

I know it's a very bad way to solve the problem but it's working and I=20
don't have more time.


Vojtech Pavlik a =E9crit :

>On Mon, Feb 09, 2004 at 12:03:14AM +0100, Bernd Schubert wrote:
>
> =20
>
>>On Sun, Feb 08, 2004 at 11:19:32PM +0100, aeriksson-97jfqw80gc6171pxa8y+qA@public.gmane.org wrote:
>>   =20
>>
>>>>>Problem still occurs :-(
>>>>>         =20
>>>>>
>>>>I have good news - I've managed to reliably reproduce the bug on my
>>>>machine and that means I now have a good chance to find and fix it.
>>>>
>>>>       =20
>>>>
>>>Another data point. I just tried switching to a non-preempt kernel as
>>>was suggested by someone. The problem still occurs.
>>>     =20
>>>
>
> =20
>
>>Hello,
>>
>>on IBM Thinkpads R31 this is also easiliy to reproduce:
>>
>>For 2.6. one only needs to read from /proc/apm or /proc/acpic/...
>>and the mouse becomes crazy and one gets the throwing 2 bytes away
>>messages in the log files. By fast reading in an endless loop even
>>input from the keyboard is ignored.
>>
>>For 2.4. this only happens on reading from /proc/apm, somehow acpi is n=
ot
>>affected in 2.4. kernel versions.
>>
>>Well, for R31's it is said that it is the bad bios, but maybe its
>>related? Any ideas why it doesn't happen with acpi and 2.4.?=20
>>   =20
>>
>
>There are many reasons why it can happen. I'm currently debugging the
>one where no APM or ACPI or anything else is needed.
>
> =20
>
>>My knowlege of the kernel interals is quite low and pretty much limited
>>to the basic vfs area, so could you please give me some good advises ho=
w to
>>debug this?
>>   =20
>>
>
>You can enable DEBUG in i8042.c, and then look at 'dmesg' when the
>problem happens. There will be a missing byte in the stream ...
>
> =20
>


--------------020504090203080602070609
Content-Type: text/html; charset=us-ascii
Content-Transfer-Encoding: 7bit

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
  <meta content="text/html;charset=ISO-8859-1" http-equiv="Content-Type">
  <title></title>
</head>
<body bgcolor="#ffffff" text="#000000">
I resolved this problem. It's the fault of the multiplexing on i8042.
You must pass i8042_nomux=1 to the kernel for 2.4.X or 2.6.0 or you
must modify <br>
linux-2.6.x/drivers/input/serio/i8042.c by quoting many lines if &gt;
2.6.0 because nomux doesn't work :<br>
<br>
<br>
/*&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!i8042_noaux &amp;&amp;
!i8042_check_aux(&amp;i8042_aux_values)) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!i8042_nomux &amp;&amp;
!i8042_check_mux(&amp;i8042_aux_values))<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (i = 0; i &lt; 4; i++) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; i8042_init_mux_values(i8042_mux_values
+ i, i804<br>
2_mux_port + i, i);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; i8042_port_register(i8042_mux_values +
i, i8042_<br>
mux_port + i);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; else<br>
*/&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <br>
&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; i8042_port_register(&amp;i8042_aux_values,
&amp;i8042_aux_port);<br>
//&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
<br>
I know it's a very bad way to solve the problem but it's working and I
don't have more time.<br>
<br>
<br>
Vojtech Pavlik a &eacute;crit&nbsp;:
<blockquote cite="mid20040208233052.GA17570-+ZI9xUNit7I@public.gmane.org" type="cite">
  <pre wrap="">On Mon, Feb 09, 2004 at 12:03:14AM +0100, Bernd Schubert wrote:

  </pre>
  <blockquote type="cite">
    <pre wrap="">On Sun, Feb 08, 2004 at 11:19:32PM +0100, <a class="moz-txt-link-abbreviated" href="mailto:aeriksson-97jfqw80gc6171pxa8y+qA@public.gmane.org">aeriksson@fastmail.fm</a> wrote:
    </pre>
    <blockquote type="cite">
      <blockquote type="cite">
        <blockquote type="cite">
          <pre wrap="">Problem still occurs :-(
          </pre>
        </blockquote>
        <pre wrap="">I have good news - I've managed to reliably reproduce the bug on my
machine and that means I now have a good chance to find and fix it.

        </pre>
      </blockquote>
      <pre wrap="">Another data point. I just tried switching to a non-preempt kernel as
was suggested by someone. The problem still occurs.
      </pre>
    </blockquote>
  </blockquote>
  <pre wrap=""><!---->
  </pre>
  <blockquote type="cite">
    <pre wrap="">Hello,

on IBM Thinkpads R31 this is also easiliy to reproduce:

For 2.6. one only needs to read from /proc/apm or /proc/acpic/...
and the mouse becomes crazy and one gets the throwing 2 bytes away
messages in the log files. By fast reading in an endless loop even
input from the keyboard is ignored.

For 2.4. this only happens on reading from /proc/apm, somehow acpi is not
affected in 2.4. kernel versions.

Well, for R31's it is said that it is the bad bios, but maybe its
related? Any ideas why it doesn't happen with acpi and 2.4.? 
    </pre>
  </blockquote>
  <pre wrap=""><!---->
There are many reasons why it can happen. I'm currently debugging the
one where no APM or ACPI or anything else is needed.

  </pre>
  <blockquote type="cite">
    <pre wrap="">My knowlege of the kernel interals is quite low and pretty much limited
to the basic vfs area, so could you please give me some good advises how to
debug this?
    </pre>
  </blockquote>
  <pre wrap=""><!---->
You can enable DEBUG in i8042.c, and then look at 'dmesg' when the
problem happens. There will be a missing byte in the stream ...

  </pre>
</blockquote>
<br>
</body>
</html>

--------------020504090203080602070609--


-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
