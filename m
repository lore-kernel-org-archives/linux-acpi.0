From: Jonas Petersson <zap-7RBX4Gk6oWI@public.gmane.org>
Subject: Re: PROBLEM: ACPI crashes (2.6.2-rc2-mm1)
Date: Thu, 29 Jan 2004 08:32:01 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <4018B6F1.3070607@xms.se>
References: <m3n087khfl.fsf@reason.gnu-hamburg> <401811E8.8060003@pca.it> <20040128200719.M75620@morningdave.org> <40181916.2050408@xms.se> <40182D90.8090102@pca.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <40182D90.8090102-wlebWZzHoyE@public.gmane.org>
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
> on 01/28/04 21:18, Jonas Petersson wrote:
>>For the record: Several of us over on the swsusp list appear to have
>>rouchly the same problem: With some effort and fiddling (as described in
>>the previous mail), swsusp2 works for console and even from
>>unaccelerated X, but whenever DRI ang AGP is enabled it resume will
>>crash. [...]
> 
> just for the record, in my case, 'swsusp' (normal, not the 'swsusp2' by
> Nigel Cunningham) works *perfectly* without DRI and AGP. 'Perfectly'
> means that I can suspend from X (obviously, unaccelerated) and
> successfully resume on X with the USB and ALSA (0.9.7) modules loaded
> (but as I don't have any USB devices here, I can't tell if USB working
> let you suspend/resume). This is a starting point, I hope, even for the
> 'swsusp' mode.

Yep, sounds like we are in the same state. I've not been around long
enough to know the whole history for sure, but it appears that Nigel has
worked for quite some time on swsusp on 2.4 and Pavel has worked on a
2.6(pre) as different branches some original "swsusp". Now that Nigel is
going 2.6 the two branches are rather different and hence Nigel's 2.6
version is called swsusp2 while his 2.4 version is just swsusp. Somewhat
confusing... So far Nigels stuff is only available as a patch.

>>[...] Some of us think this is related to the agpgart rewrite for
>>2.6.x, but our patching so far have not made any difference. There seem
>>to be resume code in the intel-agp plug which we have tried to duplicate
>>in sis-agp, but it appears not to be called during resume...
> 
> Well, I could try on 2.4.23 to find out if the problem is 2.6 or not.
> Anyway, what is strange is that the problem is on an Intel graphics
> chipset, so it the 'intel-agp' has some resume code, it /should/ work.
> And this isn't the case :-(

Well, I can say that my system suspends and resumes flawlessly from
2.4.x with accelerated X - I've had several hundreds of cycles since I
installed (early autumn). No crashes at all, but a handful of failed
suspends while hunting down some incompatible drivers - for instance the
 LinuxAnt driver for the builtin wireless card...

				/ Jonas
-- 
Jonas Petersson  |  XMS Penvision  |  mailto:Jonas.Petersson-7RBX4Gk6oWI@public.gmane.org
Box 3294, Västgötegatan 13, S-600 03 Norrköping | http://www.xms.se/
Tel: +46 11 400 13 00 | Dir: +46 11 400 13 05 | Fax: +46 11 10 30 50



-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
