From: Ducrot Bruno <ducrot-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>
Subject: Re: EC SCI model?
Date: Wed, 25 Jun 2003 18:19:33 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20030625161933.GL19556@poupinou.org>
References: <20030624163306.N70961@root.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20030624163306.N70961-Y6VGUYTwhu0@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Nate Lawson <nate-Y6VGUYTwhu0@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Tue, Jun 24, 2003 at 04:40:23PM -0700, Nate Lawson wrote:
> I am a FreeBSD developer but this is a more general question with ACPI.  I
> looked through the spec (especially 13 Embedded Controller) and I have a
> question regarding the IBF/OBF stuff.  Testing has shown that I get
> multiple callbacks of my EcGpeHandler() routine even when IBF and OBF have
> not changed.  Isn't the GPE only supposed to trigger when they change (and
> only once)?  I've gotten more reliability by waiting for the GPE, checking
> the status and if it isn't what I'm waiting for, go back to sleep.
> 
> Also, what is the procedure for sleeping while holding the ACPI Global
> Lock?  I need to sleep while waiting for the GPE to trigger between each
> phase of read and write (i.e. command, address, data).  I'm not using
> burst mode but may consider implementing it to make this easier and avoid
> the sleep altogether.
> 

Look at the NetBSD implementation of the EC.  It look stable for me, and do not
have the GPL issue...

-- 
Ducrot Bruno

--  Which is worse:  ignorance or apathy?
--  Don't know.  Don't care.


-------------------------------------------------------
This SF.Net email is sponsored by: INetU
Attention Web Developers & Consultants: Become An INetU Hosting Partner.
Refer Dedicated Servers. We Manage Them. You Get 10% Monthly Commission!
INetU Dedicated Managed Hosting http://www.inetu.net/partner/index.php
