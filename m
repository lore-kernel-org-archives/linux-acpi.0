From: Patrick Mochel <mochel-3NddpPZAyC0@public.gmane.org>
Subject: Re: Sneaking patches in (was Re: System hang when trying to
 enter sleep/standby state)
Date: Mon, 17 Feb 2003 10:25:12 -0600 (CST)
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <Pine.LNX.4.33.0302171016320.1034-100000@localhost.localdomain>
References: <20030217131922.GC4704@atrey.karlin.mff.cuni.cz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20030217131922.GC4704-jyMamyUUXNJG4ohzP4jBZS1Fcj925eT/@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
Cc: ACPI mailing list <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org


On Mon, 17 Feb 2003, Pavel Machek wrote:

> Hi!
> 
> > > I have not seen any patch on the lists, *and*
> > > you also moved big blocks of code to hide your
> > > changes. That's pretty nasty behaviour.
> > 
> > That's not true. The patch to make that change is here: 
> > 
> > http://marc.theaimsgroup.com/?l=acpi4linux&m=104508487609853&w=2
> > 
> > And the accusation about moving large blocks of code to cover it up is 
> > completely unfair. It's not a conspiracy. 
> 
> While I agree it is not a conspiracy, the change is still well
> hidden. Relevant changesets are:

Actually, the relevant changeset is 

ChangeSet-6YnWl+pQIM5bgfau97FWYA@public.gmane.org, 2003-02-12 15:12:58-06:00, mochel@osdl.org
  sleep: fix /proc/acpi/sleep write handling.
  
  - Prevent users from screwing themselves by removing support for entering
    S5 from the proc file. S5 is 'soft-off' and the state the system enters
    when powering down. It needs to be preceded by a proper shutdown sequence
    and should not be triggered manually. 
  - Fix a potential unchecked array reference using the written value as the
    index.

The patch is 


diff -Nru a/drivers/acpi/sleep.c b/drivers/acpi/sleep.c
--- a/drivers/acpi/sleep.c      Mon Feb 17 10:18:20 2003
+++ b/drivers/acpi/sleep.c      Mon Feb 17 10:18:20 2003
@@ -318,14 +318,14 @@
        size_t                  count,
        loff_t                  *ppos)
 {
-       acpi_status             status = AE_OK;
+       acpi_status             status = AE_ERROR;
        char                    state_string[12] = {'\0'};
        u32                     state = 0;
 
        ACPI_FUNCTION_TRACE("acpi_system_write_sleep");
 
        if (count > sizeof(state_string) - 1)
-               return_VALUE(-EINVAL);
+               goto Done;
 
        if (copy_from_user(state_string, buffer, count))
                return_VALUE(-EFAULT);
@@ -333,22 +333,25 @@
        state_string[count] = '\0';
                                
        state = simple_strtoul(state_string, NULL, 0);
-                               
+                               
+       if (state < 1 || state > 4)
+               goto Done;
+
        if (!sleep_states[state])
                return_VALUE(-ENODEV);                                          
 
 #ifdef CONFIG_SOFTWARE_SUSPEND                                                 
        if (state == 4) {
                software_suspend();
-               return_VALUE(count);
+               goto Done;      
        }                       
 #endif                         
        status = acpi_suspend(state);
-                               
+ Done:                         
        if (ACPI_FAILURE(status))
-               return_VALUE(-ENODEV);
-       
-       return_VALUE(count);
+               return_VALUE(-EINVAL);
+       else
+               return_VALUE(count);
 }
 
 static int acpi_system_alarm_seq_show(struct seq_file *seq, void *offset)

(Careful, cut-n-pasted from an xterm)


> Even with the changelogs, I can't decide which one of these it
> is. Probably 2.19, but as it also moves files, commit list is useless
> because it represent moves as delete all lines, add all lines, and any
> change is hidden.

As a personal choice, I _never_ make changes when I move files. I've been 
so pissed at Andy for unintentionally obscuring changes this way that I 
swore I would never do it myself. :)

> -
> -	/* Install the soft-off (S5) handler. */
> -	if (sleep_states[ACPI_STATE_S5]) {
> -		pm_power_off = acpi_power_off;
> -
> -		/* workaround: some systems don't claim S4 support,
> but they
> -                   do support S5 (power-down). That is all we need,
> so
> -		   indicate support. */
> -		sleep_states[ACPI_STATE_S4] = 1;
> -	}
>  
>  	return_VALUE(0);
> 
> Are you sure about this one?

Definitely. The setting of pm_power_off was moved to poweroff.c. 

The other part is bogus. S5 is not a sleep state, and shouldn't be treated 
as such. You can still do a swsusp-style suspend and enter S5, in which 
case I wouldn't recommend going through ACPI at all. You simply don't need 
it. You need to save state, etc, then just call pm_power_off(). 

The only thing you lack is a way to trigger swsusp w/o ACPI, right? 


	-pat



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
