From: "P. Christeas" <p_christ-U04EIuiosng@public.gmane.org>
Subject: Re: ACPI source release updated (20030328)
Date: Sat, 29 Mar 2003 18:11:48 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <200303291811.48633.p_christ@hol.gr>
References: <F760B14C9561B941B89469F59BA3A847E96D8E@orsmsx401.jf.intel.com> <20030329151604.GA19676@hell.org.pl>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20030329151604.GA19676-DETuoxkZsSqrDJvtcaxF/A@public.gmane.org>
Content-Disposition: inline
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Karol Kozimor <sziwan-DETuoxkZsSqrDJvtcaxF/A@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

> Thus wrote Grover, Andrew:
> > Fixed a problem where the error message "Failed to acquire semaphore"
> > would appear during operations on the embedded controller (EC).
>
> Thanks for that!
> I have one question though. Did you consider doing incremental ACPI
> patches? I'm using a heavily patched kernel with XFS filesystem support,
> and getting all these patches to work and applying all the rejects manually
> is a real pain. Incremental patches would really make life (mine, at least)
> easier. What do you think about it?
>
> (the above refers to the 2.4 kernel, with 2.5 changing so fast it isn't
> really a problem)
>
> Best regards,

I had thought of asking that as well. But it may be a pain for Andrew to make 
those.
If you have all the source-patches you've used, you might be able to do that 
yourself. Just get the 'original' 2.4, patch it with 2 different ver's of 
ACPI  and diff those.. Then you could apply that diff as a patch to your 
'overloaded' ver of 2.4.



-------------------------------------------------------
This SF.net email is sponsored by:
The Definitive IT and Networking Event. Be There!
NetWorld+Interop Las Vegas 2003 -- Register today!
http://ads.sourceforge.net/cgi-bin/redirect.pl?keyn0001en
