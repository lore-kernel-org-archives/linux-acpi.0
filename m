From: Nigel Cunningham <ncunningham-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Subject: Re: PROBLEM: ACPI crashes (2.6.2-rc2-mm1)
Date: Sat, 31 Jan 2004 11:18:02 +1300
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1075501081.15351.32.camel@laptop-linux>
References: <m3n087khfl.fsf@reason.gnu-hamburg> <401811E8.8060003@pca.it>
 <20040128200719.M75620@morningdave.org> <40181916.2050408@xms.se>
 <40182D90.8090102@pca.it> <4018B6F1.3070607@xms.se>
Reply-To: ncunningham-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-reply-to: <4018B6F1.3070607-7RBX4Gk6oWI@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Jonas Petersson <zap-7RBX4Gk6oWI@public.gmane.org>
Cc: Luca Capello <luca-wlebWZzHoyE@public.gmane.org>, ML ACPI-devel <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Hi.

On Thu, 2004-01-29 at 20:32, Jonas Petersson wrote:
> Yep, sounds like we are in the same state. I've not been around long
> enough to know the whole history for sure, but it appears that Nigel has
> worked for quite some time on swsusp on 2.4 and Pavel has worked on a
> 2.6(pre) as different branches some original "swsusp". Now that Nigel is
> going 2.6 the two branches are rather different and hence Nigel's 2.6
> version is called swsusp2 while his 2.4 version is just swsusp. Somewhat
> confusing... So far Nigels stuff is only available as a patch.

The first part is right - Pavel and I have the same original code base.
However the last needs some correction. Suspend2 is available for both
2.4 and 2.6, and it's the same core code for both, so there shouldn't be
any confusion. I intend to work toward getting the 2.6 version merged,
but this will take some time as I'm just stopping working full time on
Suspend, and so it will go on the backburner. I hope to try to do a
patch every day or two for LKML.

Regards,

Nigel
-- 
My work on Software Suspend is graciously brought to you by
LinuxFund.org.



-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
