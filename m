From: Bruno Ducrot <ducrot-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>
Subject: Re: (no subject)
Date: Sat, 7 Feb 2004 00:11:24 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20040206231124.GK13262@poupinou.org>
References: <200402062058.i16KwPA5028014@lap1.smtl.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <200402062058.i16KwPA5028014-epL5dT2ynbxW7IvYoCtsgA@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Pete Phillips <pete-MnLiQe5rda21Qrn1Bg8BZw@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, acpi4asus-user-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Fri, Feb 06, 2004 at 08:58:25PM +0000, Pete Phillips wrote:
> Hi
> 
> I took delivery yesterday of an ASUS s1300N laptop. I have got 2.4.22
> and 2.4.24 kernels with latest acpi patches. (I am running Suse 9.0 -
> the default kernel sucks with almost 100% keventd sucking the life out of
> the thing).
> 
> If I boot with acpi=off they boot perfectly well, minus of course acpi
> support! Also boot OK with acpi=ht.
>  
> However, with acpi=on, they just hang  after the "linux loading"
> sequence.
>  
> dmesg says that the ACPI has wakeup address 0xc0001000.
>  
> I am completely flumoxed !  I have seen numerous docs claiming that the
> S1300N is fine with ACPI, so either the BIOS in mine is different (?) or
> I am being a complete prat. (I accept that the latter is highly likely!)
> 

Booting with nolapic or noapic options perhaps?

-- 
Bruno Ducrot

--  Which is worse:  ignorance or apathy?
--  Don't know.  Don't care.


-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
