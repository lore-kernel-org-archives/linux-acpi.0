From: Ducrot Bruno <ducrot-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>
Subject: Re: ACPI support for add-on devices driver
Date: Thu, 6 Feb 2003 11:36:06 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20030206103606.GP1205@poup.poupinou.org>
References: <3E41EFA3.8060406@wipro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <3E41EFA3.8060406-uxC5H9eHYlcAvxtiuMwx3w@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: siva <sivakumar.subramani-uxC5H9eHYlcAvxtiuMwx3w@public.gmane.org>
Cc: acpi-devel-pyega4qmqnRoyOMFzWx49A@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Thu, Feb 06, 2003 at 10:46:19AM +0530, siva wrote:
> Hi all,
> 
> I like know what I need to do if I want to have ACPI power management 
> support in my driver for an add-on device. When I am browsing APM 
> implementation, I found that Linux kernel have general PM Interfaces 
> like pm_regsiter and pm_unregsiter. In APM driver, pm_send is being 
> called to send notification to all registered add-on devices.
> 
> In the case of ACPI, we have Device power state D0,D1,D2,D3. I like to 
> know how the interface between the ACPI driver, PM interface and ADD-ON 
> Driver happens.
> Can any one please send me some details about it?
> 

This is one of the main issue actually which is supposed to be somehow resolved
in 2.5 with the 'new device driver model' (and still have to be correctly
implemented, discuted, probably some flame war to come, etc.).

-- 
Ducrot Bruno

--  Which is worse:  ignorance or apathy?
--  Don't know.  Don't care.


-------------------------------------------------------
This SF.NET email is sponsored by:
SourceForge Enterprise Edition + IBM + LinuxWorld = Something 2 See!
http://www.vasoftware.com
