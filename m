From: "Adachi, Kenichi" <aileenja_jpn-xFOqZoH7zVZ4Eiagz67IpQ@public.gmane.org>
Subject: RE: Fan control for my Dell SmartPC
Date: Tue, 27 May 2003 01:30:13 +0900
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <001701c323a4$15271f40$354425db@sayonara>
References: <3ED2307B.8070908@free.fr>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <3ED2307B.8070908-GANU6spQydw@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: 'roychris' <roychris-GANU6spQydw@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi roychris,

> My computer regulate very very badly the fan. This is a common problem
with this 
> computer and DELL never resolv the problem. So I want to start the fan
whith my own 
> policy. Exactly, I don't know how my Embedded Controller interact with
Fan Controller 
> and I don't know if I can (how my computer control the fan without
ACPI ?)

Is your machine a sibling of Inspiron 8200? 
http://sourceforge.net/mailarchive/message.php?msg_id=3633122

Perhaps you may not waste your time by attempting Fan control through
ACPI, and do:
- ask your make to provide the equivalent for "Dell-laptop driver" on
Linux, but it will not happen so easily... 
- write a small driver of your own which directly uses SMBus for Fan
control, but again only limited information for Fan control is supplied,
no? 

Does anyone know if "lm_sensors" stuff works for roychris?
Is it just for monitoring purpose only? Or am I completely off base?

Thanks,
- Adachi, Kenichi

  




-------------------------------------------------------
This SF.net email is sponsored by: ObjectStore.
If flattening out C++ or Java code to make your application fit in a
relational database is painful, don't do it! Check out ObjectStore.
Now part of Progress Software. http://www.objectstore.net/sourceforge
