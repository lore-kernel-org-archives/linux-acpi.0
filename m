From: Manish Prasad <mprasad-EX0cT3Az47bauI2f2gSDlQ@public.gmane.org>
Subject: DPMS state transition times
Date: Tue, 13 May 2003 17:43:59 -0400 (EDT)
Sender: linux-pm-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <Pine.GSO.4.53.0305131738580.14796@compserv2>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-pm-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Errors-To: linux-pm-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:linux-pm-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:linux-pm-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-pm-devel>,
	<mailto:linux-pm-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-pm-devel>,
	<mailto:linux-pm-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-pm-devel>
To: linux-pm-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi

I apologize if this isn't too relevant to this list.

I am trying to measure the time it takes to transition between DPMS ON
state to various low power (standby, suspend and off) states, and back by
instrumenting X server.

The X server, basically writes into hardware registers which ultimately
turn off the screen and also turn off vertical and/or horizontal sync.

Is it possible to measure purely by software (say by polling a register)
the time it takes for this transition to complete i.e. the time it
takes to turn the display off after writing to the DPMS mode register.

I'm working with Intel i810 graphics hardware.

Any help would be greatly appreciated.

Thanks !
--Manish


-------------------------------------------------------
Enterprise Linux Forum Conference & Expo, June 4-6, 2003, Santa Clara
The only event dedicated to issues related to Linux enterprise solutions
www.enterpriselinuxforum.com
