From: Ducrot Bruno <ducrot-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>
Subject: Re: heatload 0.4 now with throttling support
Date: Thu, 19 Dec 2002 13:09:48 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20021219120948.GG4257@poup.poupinou.org>
References: <3E008120.5080908@uni-muenster.de> <20021218153355.GK347@poup.poupinou.org> <3E009EB5.7010109@muenster.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <3E009EB5.7010109-iYtK5bfT9M8b1SvskN2V4Q@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Malte Thoma <thoma-iYtK5bfT9M8b1SvskN2V4Q@public.gmane.org>
Cc: Ducrot Bruno <ducrot-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>, ACPI-Devel <Acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

On Wed, Dec 18, 2002 at 05:13:41PM +0100, Malte Thoma wrote:
> 
> 
> Ducrot Bruno wrote:
> 
> >After dpkg and heatload, get
> >Sorry can't open any of the following files:
> >	 /proc/acpi/thermal_zone/THRM/temperature
> >	 /proc/acpi/thermal/0/status
> >
> >But
> ># ls /proc/acpi/thermal_zone/
> >THM0
> >
> >
> >Please fix by parsing the entry of /proc/acpi/thermal_zone, 
> >

It is exactly the same as for your /proc/acpi/thermal_zone/THRM/temperature

You can not know in advance what will be the name of
/proc/acpi/thermal_zone/THRM

The 'name' THRM is actually given by the BIOS (by the DSDT, in fact).

the only 'clean' way to go is to get the entry(ies) of

/proc/acpi/thermal_zone/

Doing something like (not tested):

char *get_the_name_of_that_damned_temp_file(void)
{
	int		n;
	int		i;
	struct dirent **temp;
	char	       *name;

	static char temperature[4096];		/* OK.. we can do certainly better here via malloc.. */


	n = scandir("/proc/acpi/thermal_zone", &temp, 0, alphasort);

	if (n < 0) {
		return NULL;
	}

	for (i = 0; i < n; i++) {
		/* skip .* */
		if ((temp[i]->d_name)[0] == '.')
			continue;

		name = temp[i]->d_name;
		sprintf(temperature, "/proc/acpi/thermal_zone/%s/temperature", name);
		free(temp);
		return temperature;
	}
	free(temp);
	return NULL;
}

It should return the first 'temperature' file for all newer release of ACPI.
For 'older', it is OK for /proc/acpi/thermal/0/temperature

Then, that file contain:
ducrot@novae:~$ cat /proc/acpi/thermal_zone/THM0/temperature 
temperature:             45 C


(I must admit also that I don't know for /proc/acpi/thermal/0/temperature,
'older' way).

Cheers,

-- 
Ducrot Bruno

--  Which is worse:  ignorance or apathy?
--  Don't know.  Don't care.


-------------------------------------------------------
This SF.NET email is sponsored by: Geek Gift Procrastinating?
Get the perfect geek gift now!  Before the Holidays pass you by.
T H I N K G E E K . C O M      http://www.thinkgeek.com/sf/
