From: Ducrot Bruno <ducrot-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>
Subject: Re: custom dsdt with 2.5
Date: Fri, 9 May 2003 19:47:05 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20030509174705.GD10150@poup.poupinou.org>
References: <1052501708.3ebbe6ccf3454@imp.free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1052501708.3ebbe6ccf3454-HZaT1/I6gcdWj0EZb7rXcA@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: roychris-GANU6spQydw@public.gmane.org
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, Ducrot Bruno <ducrot-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

On Fri, May 09, 2003 at 07:35:08PM +0200, roychris-GANU6spQydw@public.gmane.org wrote:
> Bruno, your patch is rejected by the 2.5.69. But thanks to your help, it's
> working now. I can use my custom dsdt.

acpi-custom-DSDT.patch should work, (but I have not tested it) is
not my patch.

> But my problem is not solve. When I try the 3 sleep state, all my peripherics
> are shutted down (but I don't have the sleep LED on), but when I want to resume,
> only the cdrom wakes up ! And when I try the 4 state, after the driver frees the
> memory, I have a very fast (too fast to read it) message that is indefinitively
> repeated. I think that it's a dump mem (something like kernel panic maybe).
> 
> How can I have this message ?
> Does anyone have the same troubles ?

I can not tell because I have an hardware failure in my laptop, but
I should bought a new one soon.

-- 
Ducrot Bruno

--  Which is worse:  ignorance or apathy?
--  Don't know.  Don't care.


-------------------------------------------------------
Enterprise Linux Forum Conference & Expo, June 4-6, 2003, Santa Clara
The only event dedicated to issues related to Linux enterprise solutions
www.enterpriselinuxforum.com
