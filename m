From: Daniele Boffi <boffi-piYtxHxN1XRAly3Pu9w1wA@public.gmane.org>
Subject: Re: fan control
Date: Fri, 2 May 2003 11:53:53 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20030502115353.D2867@fermat.unipv.it>
References: <B900970C7DD9474C972986EB3EC7C58F12EC9A@andromeda.agcad.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <B900970C7DD9474C972986EB3EC7C58F12EC9A-PWLG29+z7hEKeIAE67mlpo2P0GrZ+RbP@public.gmane.org>; from Herbert.Nachtnebel-8zxNtbQCHXIjuwv8T7myQQ@public.gmane.org on Fri, May 02, 2003 at 10:17:22AM +0200
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

> > >   After stop it, try to compile a kernel, it must level up the
> > > temperature and spin up the fan.
> > > 
> 
> Yes it will, if not please report it to the list.
> 

OK, sorry for the confusion. I took the risk of burning my CPU (you succeded in
convincing me that it was not a big risk) and.... since I am wrinting from my
laptop... this means that I didn't burn it.

During some heavy job, the temperature reached 73 C maximum (which is not too
hot, I think). cat /proc/acpi/fan/*/* showed

status:                  off
status:                  off
status:                  off
status:                  off

at the beginning (about 50 C).
Then, which is strange, it looked like

status:                  off
status:                  off
status:                  on
status:                  off

when the temperature was more than 62 C and, finally

status:                  off
status:                  on
status:                  on
status:                  off

The fan was spinning accordingly.
After the end of the job, the fan stopped, temperature went down to 60 C and
acpi reported everything off.
I think everything works as expected, there is some issue with reporting the
status in /proc/acpi, since usually I never see the second state (from bottom)
on if the first one is off.

Opposite (passed) test.
I spinned up the fan at maximum speed (all states on) when temperature was
about 60 C. After temperature went below 48 C the fan stopped and all status
is reported off in /proc/acpi.

As a conclusion, I am now convinced that my bios is smart enough and that
there is no risk of burning the CPU. Acpi does a good job, some report is not
correct (same is happening with processor performance: works fine but is
always reporting status P0).

Daniele


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
