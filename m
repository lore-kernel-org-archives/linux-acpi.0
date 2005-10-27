From: Radoslaw Chyra <chyras-foVc9aoM7mKFAqYqPk0RtA@public.gmane.org>
Subject: Re: Acer Extensa 3002 WLMi: DSDT fixed but system misses keyboard and mouse events
Date: Thu, 27 Oct 2005 18:13:55 +0000 (UTC)
Message-ID: <loom.20051027T195942-349@post.gmane.org>
References: <435D43BB.2080702@rrz.uni-koeln.de> <loom.20051027T072257-534@post.gmane.org> <200510271842.37571.sorosj@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

john <sorosj@...> writes: 
 
> i've got the same notebook (tm4001LMI - 512mb ram - ati9600 - ipw2200). 
> I'm still using acpi-sbs kernel modules to read my battery, but this doesn't  
> enable me to suspend-to-ram. if fixing the DSDT does, can you send your fixed  
> dsdt as attachement? would be great to turn on-off the machine in a snap! 
 
No, fixing DSDT only enables me to drop acpi-sbs kernel modules (which in turn 
cause problem with disappearing battery entries from /proc/acpi for me). 
Suspend-to-ram neither works with acpi-sbs nor with patched/fixed DSDT. Laptop 
suspends to ram but after pressing Power Button or any of the keys there is 
only disk spin-up but screen stays dark and USB power is down (mouse and 
external keyboard stay dark) and touching Caps Lock does nothing. 
 
So, with acpi-sbs modules I had problem with disappearing battery, but keyboard 
worked OK. With patched/fixed DSDT battery is OK, but keyboard behaves bad. 
With the two I chose the latter and attached external USB keyboard which works 
OK. 
 
If you are still interested I can send you my patched/fixed DSDT, just drop me 
private message. 
 
Regards, 
 
Radoslaw 
 
 



-------------------------------------------------------
This SF.Net email is sponsored by the JBoss Inc.
Get Certified Today * Register for a JBoss Training Course
Free Certification Exam for All Training Attendees Through End of 2005
Visit http://www.jboss.com/services/certification for more information
