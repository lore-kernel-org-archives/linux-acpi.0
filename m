From: Knut Neumann <knut.neumann-4bfl1RV3iZDOEhgYWvzSCYQuADTiUCJX@public.gmane.org>
Subject: Re: s3 on vaio z600
Date: Mon, 31 Mar 2003 01:06:07 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1049065566.914.30.camel@localhost>
References: <1048682112.501.11.camel@localhost>
 <20030328205923.GG5147@zaurus.ucw.cz>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="Boundary_(ID_M5mXhn48zkjFr72kmju4XA)"
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-reply-to: <20030328205923.GG5147-VNkyu7EogrqGmfs5Z0+9fw@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Pavel Machek <pavel-AlSwsSmVLrQ@public.gmane.org>
Cc: acpi-devel-pyega4qmqnRoyOMFzWx49A@public.gmane.org
List-Id: linux-acpi@vger.kernel.org


--Boundary_(ID_M5mXhn48zkjFr72kmju4XA)
Content-type: text/plain
Content-transfer-encoding: 7BIT

Am Fre, 2003-03-28 um 21.59 schrieb Pavel Machek: 
> > Now, I would really appreciate any hint, how I can gather more
> > information. Is there any chance to find out wether it actually jumps
> > into wakeup.S after resume?
> 
> Few leds on parallel port may do the trick... along with outb() in wakeup.S.

Ole Rohne told me to use lcall $0xffff, $0 in wakeup.S, which I did in
the first place and nothing happened. Since according to him this is
supposed to reboot the computer I concluded that there is either
something wrong with the wakeup-vector or with _WAK (there is no BFS in
my DSDT). Thus I tried to jmp to the wakeup-vector from
acpi_enter_sleep_state wich worked (besides it led to a general
protection fault after a few instructions - I guess thats because I am
not in real mode?!). So it seems it never even gets there when resuming.

So I did - as you suggested - disassebmle the DSDT and had a look at the
WAK method (attached) - but everything seems fine as far as I can
tell...so I am totally stuck now. 

Next thing I wanted to try is to put system in real mode before jumping
to the wakeup-vector just to have a look if that really is the
problem...

Any suggestions?

Thank you for your help anyway. I really appreciate it.

-Knut


--
"Marriage is the alliance of two people,one of whom never remembers
birthdays and the other never forgets them." - Ogden Nash

--Boundary_(ID_M5mXhn48zkjFr72kmju4XA)
Content-type: text/plain; charset=ISO-8859-1; name=z600.wak
Content-disposition: attachment; filename=z600.wak
Content-transfer-encoding: 7BIT

00002ec0: Method _WAK (\_WAK)
00002ec7:   ArgCount 1; NotSerialized
00002ec8:   Store
00002ec9:     0x00
00002ecb:     \_SB_.PCI0.CRST (0000052f)
00002eda:   If
00002edc:     LEqual
00002edd:       Arg0
00002ede:       0x01
00002ee0:     <NULL>
00002ee4:     0xe0
00002ee6:   If
00002ee9:     LEqual
00002eea:       Arg0
00002eeb:       0x04
00002eed:     <NULL>
00002f04:     \_SB_.PCI0.ISA_.SPIC.SSRC (00001d64)
00002f1b:     If
00002f1d:       LEqual
00002f1e:         <NULL>
00002f22:         \_OS_
00002f27:       "Microsoft Windows NT"
00002f3d:       ZeroOp
00002f3e:       <NULL>
00002f42:       0xe6
00002f44:     Else
00002f46:       If
00002f48:         LNotEqual
00002f4a:           <NULL>
00002f4e:           \_OS_
00002f53:         "Microsoft Windows"
00002f66:         ZeroOp
00002f67:         <NULL>
00002f6b:         0xe6
00002f6d:   If
00002f6f:     LEqual
00002f70:       <NULL>
00002f74:       \_OS_
00002f79:     "Microsoft Windows NT"
00002f8f:     ZeroOp
00002f90:     Noop
00002f91:   Else
00002f93:     If
00002f95:       LNotEqual
00002f97:         <NULL>
00002f9b:         \_OS_
00002fa0:       "Microsoft Windows"
00002fb3:       ZeroOp
00002fb4:       Noop
00002fb5:     Else
00002fb7:       Notify
00002fb8:         \_SB_.PWRB (000004e2)
00002fc2:         0x02
00002fc4:   Return
00002fc5:     ZeroOp

--Boundary_(ID_M5mXhn48zkjFr72kmju4XA)--


-------------------------------------------------------
This SF.net email is sponsored by:
The Definitive IT and Networking Event. Be There!
NetWorld+Interop Las Vegas 2003 -- Register today!
http://ads.sourceforge.net/cgi-bin/redirect.pl?keyn0001en
