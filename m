From: Ducrot Bruno <ducrot-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>
Subject: Re: Re: acpi on medion laptop
Date: Mon, 20 Oct 2003 18:37:12 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20031020163712.GA13989@poupinou.org>
References: <28747088.1066556260752.JavaMail.www@wwinf0102>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <28747088.1066556260752.JavaMail.www-PMdOW1uaTljBkAz3hwFLjg@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Nicolas Olivero <nicolas.olivero-39ZsbGIQGT5GWvitb5QawA@public.gmane.org>
Cc: Yury Umanets <umka-nJ1KrdHEGnBBDgjK7y7TUQ@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Sun, Oct 19, 2003 at 11:37:40AM +0200, Nicolas Olivero wrote:
> hello, 
> first thanks for trying to help me....
> I compiled both kernel 2.4.23 and 2.6.0 but i still have the same problem.
> acpi works for my battery, i can see its level, but i can't see the thermal, fan informations :( 
> another idea to resolve my problem?
> 
> does it mean that my processor is in danger? i think my fan works less often than before without acpi...
> 

Your processor support C2, so it is a little bit more cooled when going
to the idle loop if you do not enable acpi.

There is also good chance that your dsdt do not have any kind of
thermal support from acpi point-of-view.



-- 
Ducrot Bruno

--  Which is worse:  ignorance or apathy?
--  Don't know.  Don't care.


-------------------------------------------------------
This SF.net email sponsored by: Enterprise Linux Forum Conference & Expo
The Event For Linux Datacenter Solutions & Strategies in The Enterprise 
Linux in the Boardroom; in the Front Office; & in the Server Room 
http://www.enterpriselinuxforum.com
