From: Paul Ionescu <i_p_a_u_l-/E1597aS9LQAvxtiuMwx3w@public.gmane.org>
Subject: Re: ibm-acpi-0.5 direct download
Date: Mon, 18 Oct 2004 12:57:15 -0700 (PDT)
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20041018195715.77215.qmail@web50203.mail.yahoo.com>
References: <20041018170834.GH17013@aero.ensim.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20041018170834.GH17013-AKoe11r2kkOzaBltdDZI6w@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Borislav Deianov <borislav-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, linux-thinkpad-l7BEYHA5S10i5T99jlK1Sh2eb7JE58TQ@public.gmane.org, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi Boris,

Here is my feedback for the experimental features:
On T41 and R50p

CMOS:

0 - no effect but tpb reports "Volume down"
1 - no effect but tpb reports "Volume up"
2 - no effect but tpb reports "Mute on"
3 - simulate pressing the "Access IBM" button in tpb
4 - no effect but tpb reports LCD brightness up
5 - no effect but tpb reports LCD brightness down
11 - no effect but tpb reports Zoom togle
12 - ThinkLight on and report that in tpb
13 - ThinkLight off and report that in tpb
14 - no effect but tpb reports ThinkLight status
change

LED:
0 - power
1 - battery (orange)
2 - battery (green)
4 - UltraBay
7 - standby (moon)
all functions are supported (on/off/blink)

BEEP:
0 - stops whatever beep is running
2 - two beeps, pause, third beep
3 - single beep
4 - "unable"    
5 - single beep
6 - "AC/DC"
7 - high-pitched beep
9 - three short beeps
10 - very long beep
12 - low-pitched beep
15 - three short beeps repeated forever (stop with 0)
16 - single beep repeated forever (stop with 0)

--- Borislav Deianov <borislav-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
wrote:

> On Mon, 18 Oct 2004 15:56:03 +0000 (UTC) Paul
> Ionescu <i_p_a_u_l-/E1597aS9LQAvxtiuMwx3w@public.gmane.org> wrote:
> >
> > I receive an error when I try to download it form
> sourceforge.
> > Version 0.4 can be downloaded but not v0.5.
> 
> Seems to be a SF problem. I've added a direct
> download link to the
> homepage until they fix it.
> 
> http://ibm-acpi.sf.net/ibm-acpi-0.5.tar.gz
> 
> Boris
> 



	
		
__________________________________
Do you Yahoo!?
Yahoo! Mail - You care about security. So do we.
http://promotions.yahoo.com/new_mail


-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
